# servidor de Figuras
# para testa-lo, use como cliente o telnet
# Ex: telnet localhost 7777

from socket import *
from threading import *
from tkinter import *

HOST = ''   # hostname
PORT = 7777 # comm port

class Grid:
	def __init__(self, master, lins, cols, cell_h = 50, cell_w = 50):
		self.cell_h = cell_h
		self.cell_w = cell_w
		self.maxlins = lins
		self.maxcols = cols
		h = lins * cell_h + 1
		w = cols * cell_w + 1
		self.w = Canvas(master, height = h, width = w)
		self.w.configure(borderwidth=0, highlightthickness=0)
		self.w.pack()
		for i in range(0, h, cell_h):
			self.w.create_line([(i, 0), (i, h)])
		for i in range(0, w, cell_w):
			self.w.create_line([(0, i), (w, i)])

	def draw_circle(self, lin, col):
		x = col * self.cell_h
		y = lin * self.cell_w
		return self.w.create_oval(x + 10, y + 10,
			x + self.cell_w - 10, y + self.cell_h - 10,
			fill = 'blue', outline = '')

class Server(Thread):

	def __init__(self, grid):
		Thread.__init__(self)
		self.grid = grid
		self.server = socket()
		self.server.bind((HOST, PORT))
		self.server.listen(5)
		self.client, addr = self.server.accept()

	def process_cmd(self, cmd):
		# + shape(c|s) color lin col
		# - shape(c|s) color
		# m shape(c|s) color lin col
		reply = 'Done.\n'
		self.grid.draw_circle(2, 2)
		return reply

	def run(self):
		while True:
			try:
				text = self.client.recv(1024)
				if not text:
					break
				reply = self.process_cmd(text)
				self.client.sendall(reply)
			except:
				break
		self.client.close()

if __name__ == '__main__':
	root = Tk()
	root.title('Grid World')
	grid = Grid(root, 5, 5, cell_h = 60, cell_w = 60)
	app = Server(grid).start()
	root.mainloop()
