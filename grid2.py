from tkinter import *

master = Tk()

w = Canvas(master, width=300, height=300)
w.pack()



#linha 5
w.create_rectangle(300, 300, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(240, 300, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(180, 300, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(120, 300, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(1, 300, 60, 60, fill="white")# x,y,width,height

#linha 4
w.create_rectangle(300, 240, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(240, 240, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(180, 240, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(120, 240, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(1, 240, 60, 60, fill="white")# x,y,width,height

#linha 3
w.create_rectangle(300, 180, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(240, 180, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(180, 180, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(120, 180, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(1, 180, 60, 60, fill="white")# x,y,width,height

#linha 2
w.create_rectangle(300, 120, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(240, 120, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(240, 120, 60, 60, fill="red")# retangulo
w.create_rectangle(180, 120, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(120, 120, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(1, 120, 60, 60, fill="white")# x,y,width,height


#linha 1
w.create_rectangle(300, 1, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(240, 1, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(180, 1, 60, 60, fill="white")# x,y,width,height
w.create_rectangle(120, 1, 60, 60, fill="white")# x,y,width,height
w.create_oval(10,10,10,10, fill="blue") # circulo
w.create_rectangle(1, 1, 60, 60, fill="white")# x,y,width,height






mainloop()
