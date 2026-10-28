import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "success",
        "message": "DevOps Microservice is running smoothly!",
        "version": "1.0.0"
    })

@app.route("/health")
def health():
    # Endpoint חיוני עבור Liveness ו-Readiness Probes ב-Kubernetes
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
