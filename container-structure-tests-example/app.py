import yaml


app = Flask(__name__)

with open("config.yaml") as stream:
  try:
    config = yaml.safe_load(stream)
  except yaml.YAMLError as exc:
    print(exc)
        
@app.route("/")
def helloworld():
    return f'Hello from ${config['appName']}'

if __name__ == "__main__":
    app.run(host="0.0.0.0")