# servidor de Figuras
import sys
import socket
#from socket import *
from threading import *
from tkinter import *
HOST = '' # hostname
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

    def within_grid(self, lin, col):
        return lin >= 0 and lin < self.maxlins and col >= 0 and col < self.maxcols

    def draw_circle(self, lin, col, color):
        if not self.within_grid(lin, col):
            return -1
        x = col * self.cell_h
        y = lin * self.cell_w
        return self.w.create_oval(x + 10, y + 10,
            x + self.cell_w - 10, y + self.cell_h - 10,
            fill = color, outline = '')
    def draw_square(self, lin, col, color):
        if not self.within_grid(lin, col):
            return -1
        x = col * self.cell_h
        y = lin * self.cell_w
        return self.w.create_rectangle(x + 10, y + 10,
            x + self.cell_w - 10, y + self.cell_h - 10,
            fill = color, outline = '')

    def delete(self, id):
        self.w.delete(id)

class Fig:
    def __init__(self, grid, x, y, color):
        self.id = -1
        self.grid = grid
        self.x = x
        self.y = y
        self.color = color

    def draw(self):
        pass

    def erase(self):
        if self.id != -1:
                self.grid.delete(self.id)
                self.id = -1
    def move_to(self, x, y):
        self.erase()
        self.x = x
        self.y = y
        self.draw()

class Square(Fig):
    def __init__(self, grid, x, y, color):
        Fig.__init__(self, grid, x, y, color)
    def draw(self):
        self.id = self.grid.draw_square(self.x, self.y, self.color)

class Circle(Fig):
    def __init__(self, grid, x, y, color):
        Fig.__init__(self, grid, x, y, color)
    def draw(self):
        self.id = self.grid.draw_circle(self.x, self.y, self.color)

class Server(Thread):
    def __init__(self, grid):
        Thread.__init__(self)
        self.grid = grid
        self.figs = {}
#        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server = socket()
        self.server.bind((HOST, PORT))
        self.server.listen(5)
        self.client, addr = self.server.accept()
    def process_cmd(self, cmd):
        # + shape(c|s) color lin col
        # - shape(c|s) color
        # m shape(c|s) color lin col
        reply = 'Done.\n'
        tokens = cmd.split()
        if len(tokens) < 3:
            reply = 'Expected at least 3 params (command, shape, color): ' + cmd
        else:
            cmd = tokens[0]
            shape = tokens[1]
            color = tokens[2]
            figid = shape + color
            if not (figid in self.figs) and cmd != '+':
                reply = 'Figure not found: ' + shape + ' ' + color + '\n'
            elif figid in self.figs and cmd == '+':
                reply = 'Figure already exists: ' + shape + ' ' + color + '\n'
            else:
                if cmd in ['+', 'm']:
                    lin = int(tokens[3])
                    col = int(tokens[4])
                    if cmd == '+':
                        if shape == 'c':
                            self.figs[figid] = Circle(self.grid, lin, col,

color)

                            self.figs[figid].draw()
                        elif shape == 's':
                            self.figs[figid] = Square(self.grid, lin, col,

color)

                            self.figs[figid].draw()
                        else:
                            reply = 'Shape not recognized\n'

                    else:
                        self.figs[figid].move_to(lin, col)

                elif cmd == '-':
                    self.figs[figid].erase()
                    del self.figs[figid]
                else:
                    reply = 'Command not recognized: ' + cmd + '\n'

        return reply

    def run(self):
        while True:
            try:
                text = self.client.recv(1024)   
                if not text:
                    break
                print ('received:', text)
                reply = self.process_cmd(text)
                self.client.sendall(reply)
                print (' sent:', reply)
            except:
                break
        self.client.close()


    def ativar_gui():
        root = Tk()
        root.title('Grid World')
        grid = Grid(root, 5, 5, cell_h = 60, cell_w = 60)
        app = Server(grid).start()
        root.mainloop()
    if __name__ == '__main__':
        ativar_gui()
