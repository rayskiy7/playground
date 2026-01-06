import tkinter
from tkinter import ttk
import time
import threading as th


window = tkinter.Tk()
window.title('Hello world app')
window.geometry('200x100')


def say_hello():
    time.sleep(3)
    print('Hello world!')


hello_button = ttk.Button(window, text='Say hello', command=say_hello)
hello_button.pack()

thread = th.Thread(target=window.mainloop)
thread.start()
thread.join()