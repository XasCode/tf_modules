resource "github_repository_file" "gh_repo_file_fn" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "functions/index.js"
  content             = <<-EOT
    const functions = require('@google-cloud/functions-framework');
    //const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
    const admin = require('firebase-admin');
    const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');

    if (admin.apps.length === 0) {
      admin.initializeApp();
    }

    functions.http('helloGET', async (req, res) => {
      const db = getFirestore();
        
      const url = req.query.url;

      const docRef = db.collection('ssllabs-scans').doc(encodeURIComponent(url));
      const doc = await docRef.get();
      const data = doc.data();

      res.send(`Retrieved: $${data.grade} !\n`);
    });

    exports.helloPubSub = async (message, context) => {
      //admin.initializeApp();
      const db = getFirestore();
      
      const msg = message.data
        ? Buffer.from(message.data, 'base64').toString()
        : 'N/A';

      const [ url, grade ] = msg.split('|');
      const docRef = db.collection('ssllabs-scans').doc(encodeURIComponent(url));

      await docRef.set({
        grade
      });

      console.log(`Recorded: $${url} - $${grade} !`);
    };
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_dockerfile,
    github_repository_file.gh_repo_file_cloudbuild_yaml
  ]
}
