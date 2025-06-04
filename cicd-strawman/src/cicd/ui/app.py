import gradio as gr

def hello(name):
    return f"Hola, {name}!"

app = gr.Interface(fn=hello, inputs="text", outputs="text", title="¡Hola mundo!")

if __name__ == "__main__":
    app.launch(server_name="0.0.0.0", server_port=7860, share=False)
