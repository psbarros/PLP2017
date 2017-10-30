from Tkinter import *

#master = Tk()

#w = Canvas(master, width=300, height=300)
#w.pack()

class Grid:
    def	__init__(self, master, lins, cols, cell_h = 50, cell_w = 50):
            self.cell_h	= cell_h
            self.cell_w	= cell_w	 
            self.maxlins = lins	
            self.maxcols = cols	
            h =	lins * cell_h +	1	 
            w =	cols * cell_w +	1   
            self.w = Canvas(master, height = h, width =	w)  
            self.w.configure(borderwidth=0,highlightthickness=0)
            self.w.pack()
            for	i in range(0, h, cell_h):
                self.w.create_line([(i, 0), (i,h)]) 
            for	i in range(0, w,cell_w):  
                self.w.create_line([(0,i),(w,i)])
	
    def draw_circle(self, lin, col): 
        x = col	* self.cell_h
        y = lin	* self.cell_w  
        return	self.w.create_oval(x + 10, y + 10,
                x + self.cell_w	- 10, y + self.cell_h - 10, 
                fill = 'blue', outline ='')
class Quadrado(object):
    
    def __init__(self, w, x = 10, y = 10, lado = 100, cor = 'blue'):
        self.w = w
        self.x = x
        self.y = y
        self.lado = lado
        self.cor = cor
        self.id = -1
    
    def desenhar(self):
        self.id = self.w.create_rectangle(self.x, self.y, 
                                          self.x + self.lado, 
                                          self.y + self.lado,
                                          outline = self.cor)

class Circulo(object):
    
    def __init__(self, w, x = 10, y = 10, raio = 100, cor = 'blue'):
        self.w = w
        self.x = x
        self.y = y
        self.raio = raio
        self.cor = cor
        self.id = -1
    
    def desenhar(self):
        self.id = self.w.create_oval(self.x - self.raio, 
                                     self.y - self.raio, 
                                     self.x + self.raio, 
                                     self.y + self.raio,
                                     outline = self.cor)

if __name__	== '__main__':	  
    m = Tk() 
    m.title('Grid World')	  
    grid =  Grid(m,5,5,cell_h = 60, cell_w = 60)
    
    w = Canvas(m, width=400, height=400)
    w.pack()

   q = Quadrado(w, 10, 10, 10, 'green')
    q.desenhar()

#    c = Circulo(w, 10, 10, 20, 'blue')
#    c.desenhar()

    m.mainloop()
