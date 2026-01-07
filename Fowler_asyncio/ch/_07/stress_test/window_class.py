import queue
import tkinter as tk
from tkinter import ttk
import typing as tp
from .stress_test_class import StressTest


class LoadTester(tk.Tk):

    def __init__(self, loop, *args, **kwargs):
        tk.Tk.__init__(self, *args, **kwargs)
        self._queue = queue.Queue()
        self._refresh_ms = 25

        self._loop = loop
        self._load_test: tp.Optional[StressTest] = None
        self.title('URL Requester')

        self._url_label = tk.Label(self, text='URL:')
        self._url_label.grid(column=0, row=0)

        self._url_field = tk.Entry(self, width=10)
        self._url_field.grid(column=1, row=0)

        self._requests_label = tk.Label(self, text='Number of requests:')
        self._requests_label.grid(column=0, row=1)

        self._requests_field = tk.Entry(self, width=10)
        self._requests_field.grid(column=1, row=1)

        self._submit = ttk.Button(self, text='Submit', command=self._start)
        self._submit.grid(column=2, row=1)

        self._pb_label = tk.Label(self, text='Progress:')
        self._pb_label.grid(column=0, row=3)

        self._pb = ttk.Progressbar(self, orient='horizontal', length=200, mode='determinate')
        self._pb.grid(column=1, row=3, columnspan=2)

    def _update_bar(self, pct: int):
        if pct == 100:
            self._pb['value'] = 0
            self._load_test = None
            self._submit['text'] = 'Submit'
        else:
            self._pb['value'] = pct
            self.after(self._refresh_ms, self._poll_queue)

    def _queue_update(self, completed_requests: int, total_requests: int):
        self._queue.put(int(completed_requests / total_requests * 100))

    def _poll_queue(self):
        if not self._queue.empty():
            percent_complete = self._queue.get()
            self._update_bar(percent_complete)
        else:
            if self._load_test:
                self.after(self._refresh_ms, self._poll_queue)

    def _start(self):
        if self._load_test is None:
            self._submit['text'] = 'Cancel'
            test = StressTest(
                self._loop,
                self._url_field.get(),
                int(self._requests_field.get()),
                self._queue_update,
            )
            self.after(self._refresh_ms, self._poll_queue)
            test.start()
            self._load_test = test
        else:
            self._load_test.cancel()
            self._load_test = None
            self._submit['text'] = 'Submit'
