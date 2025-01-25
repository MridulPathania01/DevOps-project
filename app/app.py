from flask import Flask, render_template, jsonify, request

app = Flask(__name__)

# Sample in-memory data store
data_store = {
    "items": []
}

# Home route to render HTML page
@app.route('/')
def home():
    return render_template('index.html')

# API route to get all items
@app.route('/api/items', methods=['GET'])
def get_items():
    return jsonify(data_store['items'])

# API route to add a new item
@app.route('/api/items', methods=['POST'])
def add_item():
    item = request.json
    if not item or 'name' not in item:
        return jsonify({"error": "Invalid input"}), 400

    data_store['items'].append(item)
    return jsonify(item), 201

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0',port=5000)
