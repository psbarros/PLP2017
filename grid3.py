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

    def draw_square(self, lin, col):
        x = col * self.cell_h
        y = lin * self.cell_w
        return self.w.create_rectangle(x, y, x+60, y+60, fill='blue', outline='')

    def draw_circle(self, lin, col): 
        x = col	* self.cell_h
        y = lin	* self.cell_w  
        return	self.w.create_oval(x + 60, y + 60,
                x + self.cell_w	- 60, y + self.cell_h - 60, 
                fill = 'blue', outline ='')



if __name__	== '__main__':	  
    m = Tk() 
    m.title('Grid World')	  
    grid =  Grid(m,5,5,cell_h = 60, cell_w = 60)
    
    w = Canvas(m, width=40, height=0)
    w.pack()
    

    grid.draw_square(0,0)

    m.mainloop()

