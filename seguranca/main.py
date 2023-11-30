import hashlib
from flask import Flask, request, jsonify
from virus_total_apis import PublicApi

app = Flask(__name__)

API_KEY = "62e7ba1ff4a091a4c36715027f83dba3ec5873f3d3f88f28a9072cded49a84a2"

@app.route("/api/check", methods=["POST"])
def check_file():
    try:
        file = request.files.get("file")
        print(file)
        if file is None or file.mimetype == "":
            return {"message": "File not found in request", "valid": False}

        file_hash = hashlib.md5(file.read()).hexdigest()
        api = PublicApi(API_KEY)
        result = api.get_file_report(file_hash)
        app.logger.info(f"API Response: {result}")

        if result.get("response_code") == 200:
            positives = result.get("results", {}).get("positives", 0)
            return {
                "valid": positives == 0,
                "message": "The file is valid!" if positives == 0 else "The file is not valid!"
            }

        else:
            raise ValueError(result.get("message", "The file is not valid!"))

    except KeyError as e:
        app.logger.error(f"KeyError: {e}")
        return {"message": "There was an internal server error!", "valid": False}
    except Exception as e:
        app.logger.error(f"An unexpected error occurred: {e}")
        return {"message": "There was an internal server error!", "valid": False}


if __name__ == "__main__":
    app.run(debug=True)
