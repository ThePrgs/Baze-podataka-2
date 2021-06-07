
import mysql.connector


mydb = mysql.connector.connect(
	host="localhost",
	user="root",
	password="1234",
	database="overwatch"
	)

import tkinter as tk
import mysql.connector
from tkinter import *
def submitact(): 
      
    user = username.get() 
    passw = password.get() 
    
   
    logintodb(user, passw)

    
def logintodb(user, passw): 
      
    if passw: 
        db = mysql.connector.connect(host ="localhost", 
                                     user = user, 
                                     password = passw, 
                                     db ="overwatch") 
        cursor = db.cursor() 
        
    if user== 'korisnik':
        korisnikP = Toplevel(root) 
        korisnikP.title("Korisnik") 
        korisnikP.geometry("550x50")
        slova = Label(korisnikP, text="red")
        slova.pack( side = LEFT)
        unos = Entry(korisnikP, bd =5)
        unos.pack(side = LEFT)
        slova2 = Label(korisnikP, text="tablica")
        slova2.pack( side = LEFT)
        unos2 = Entry(korisnikP, bd =5)
        unos2.pack(side = LEFT)
        
        def ispisi():
            cursor= db.cursor()
            U1=unos.get()
            U2=unos2.get()
            sql="select %s from %s" % (U1, U2);
            cursor.execute(sql)
            selectprozor2 = Toplevel(korisnikP) 
            selectprozor2.title("Select") 
            selectprozor2.geometry("800x600")
            i=0 
            for likovi in cursor: 
                for j in range(len(likovi)):
                    e = Entry(selectprozor2, width=20, fg='blue') 
                    e.grid(row=i, column=j) 
                    e.insert(END, likovi[j])
                i=i+1

        def likovi():
            cursor=db.cursor()
            sql="select i.imena as ime, i.oruzje as oruzje, m.moc as moc, m.hotkey as tipka, m.opis_moci as opis from oruzja i inner join moci m on i.imena = m.lik;"
            cursor.execute(sql)
            selectprozor3 = Toplevel(korisnikP) 
            selectprozor3.title("Upit") 
            selectprozor3.geometry("700x200")
            i=0 
            for moci in cursor: 
                for j in range(len(moci)):
                    e = Entry(selectprozor3, width=40, fg='blue') 
                    e.grid(row=i, column=j) 
                    e.insert(END, moci[j])
                i=i+1
        def mape():
            cursor=db.cursor()
            sql="select a.naziv as naziv, a.opis as opis_tipa, m.naziv as ime_mape from arkadni_tipovi a  inner join mape m on a.dozvoljene_mape = m.vrsta;"
            cursor.execute(sql)
            selectprozor3 = Toplevel(korisnikP) 
            selectprozor3.title("Upit") 
            selectprozor3.geometry("700x200")
            i=0 
            for moci in cursor: 
                for j in range(len(moci)):
                    e = Entry(selectprozor3, width=40, fg='blue') 
                    e.grid(row=i, column=j) 
                    e.insert(END, moci[j])
                i=i+1
            
        BSelect = tk.Button(korisnikP,text ='Ispisi',command=ispisi)
        BSelect.pack(side = LEFT)
        BSelect = tk.Button(korisnikP,text ='Likovi i moci',command=likovi)
        BSelect.pack(side = LEFT)
        BSelect = tk.Button(korisnikP,text ='Mape',command=mape)
        BSelect.pack(side = LEFT)

            
        
    if user== 'admin':
        izbor = Toplevel(root)    
        izbor.title("Admin")      
        izbor.geometry("100x50") 

        def lik():
            self = Toplevel(root)    
            self.title("Admin")      
            self.geometry("500x50") 
            L1 = Label(self, text="ime")
            L1.pack( side = LEFT)
            E1 = Entry(self, bd =5)
            E1.pack(side = LEFT)
            L2 = Label(self, text="klasa")
            L2.pack( side = LEFT)
            E2 = Entry(self, bd =5)
            E2.pack(side = LEFT)
          
            def insert():
                Ej=E1.get()
                Ed=E2.get()
                sql = "insert into overwatch.likovi(ime,  klasa) values (%s, %s)"
                val = (Ej, Ed)
                cursor.execute(sql,val)
                db.commit()
                
            def update():
                Ej=E1.get()
                Ed=E2.get()
                sql = "update overwatch.likovi set klasa = %s where ime = %s"
                val = (Ed, Ej)
                cursor.execute(sql,val)
                db.commit()

            def delete():
                Ej=E1.get()
                Ed=E2.get()
                sql= "delete from overwatch.likovi where ime = %s AND klasa = %s"
                val= (Ej,Ed)
                cursor.execute(sql,val)
                db.commit()

            def select():
                Ej=E1.get()
                Ed=E2.get()
                sql = "select * from likovi where ime = %s or klasa = %s"
                val = (Ej, Ed)
                cursor.execute(sql,val)
                selectprozor = Toplevel(self) 
                selectprozor.title("Select") 
                selectprozor.geometry("700x200")
                i=0 
                for likovi in cursor: 
                    for j in range(len(likovi)):
                        e = Entry(selectprozor, width=20, fg='blue') 
                        e.grid(row=i, column=j) 
                        e.insert(END, likovi[j])
                    i=i+1
                    
                    
            BInsert = tk.Button(self,text ='Insert',command = insert)
            BInsert.pack(side = LEFT)

            BUpdate = tk.Button(self,text ='Update',command = update)
            BUpdate.pack(side = LEFT)

            BDelete = tk.Button(self,text ='Delete',command = delete)
            BDelete.pack(side = LEFT)

            BSelect = tk.Button(self,text ='Select',command = select)
            BSelect.pack(side = LEFT)

            
            label = Label(self)
            label.pack()


        def mapa():
             
            self = Toplevel(root)    
            self.title("Admin")      
            self.geometry("900x50") 
            L1 = Label(self, text="naziv")
            L1.pack( side = LEFT)
            E1 = Entry(self, bd =5)
            E1.pack(side = LEFT)
            L2 = Label(self, text="vrsta")
            L2.pack( side = LEFT)
            E2 = Entry(self, bd =5)
            E2.pack(side = LEFT)
            L3 = Label(self, text="drzava")
            L3.pack( side = LEFT)
            E3 = Entry(self, bd =5)
            E3.pack(side = LEFT)
            L4 = Label(self, text="broj likova")
            L4.pack( side = LEFT)
            E4 = Entry(self, bd =5)
            E4.pack(side = LEFT)
          
          
            def insert1():
                Ej=E1.get()
                Ed=E2.get()
                Et=E3.get()
                Ec=E4.get()
                sql = "insert into overwatch.mape(naziv, vrsta, drzava, broj_likova) values (%s, %s, %s, %s)"
                val = (Ej, Ed, Et, Ec)
                cursor.execute(sql,val)
                db.commit()
                
            def update1():
                Ej=E1.get()
                Ed=E2.get()
                Et=E3.get()
                Ec=E4.get()
                sql = "update mape set broj_likova = %s where naziv= %s"
                val = (Ec, Ej)
                cursor.execute(sql,val)
                db.commit()

            def delete1():
                Ej=E1.get()
                Ed=E2.get()
                sql= "delete from mape where naziv = %s AND vrsta = %s"
                val= (Ej,Ed)
                cursor.execute(sql,val)
                db.commit()

            def select1():
                Ej=E1.get()
                Ed=E2.get()
                Et=E3.get()
                Ec=E4.get()
                sql = "select * from mape where naziv = %s or vrsta = %s or drzava = %s or broj_likova=%s"
                val = (Ej, Ed, Et, Ec)
                cursor.execute(sql,val)
                selectprozor = Toplevel(self) 
                selectprozor.title("Select") 
                selectprozor.geometry("700x200")
                i=0 
                for mape in cursor: 
                    for j in range(len(mape)):
                        e = Entry(selectprozor, width=20, fg='blue') 
                        e.grid(row=i, column=j) 
                        e.insert(END, mape[j])
                    i=i+1

            BInsert1 = tk.Button(self,text ='Insert',command = insert1)
            BInsert1.pack(side = LEFT)

            BUpdate1 = tk.Button(self,text ='Update',command = update1)
            BUpdate1.pack(side = LEFT)

            BDelete1 = tk.Button(self,text ='Delete',command = delete1)
            BDelete1.pack(side = LEFT)

            BSelect1 = tk.Button(self,text ='Select',command = select1)
            BSelect1.pack(side = LEFT)

                    
        BSelect = tk.Button(izbor,text ='Likovi',command=lik)
        BSelect.pack(side = LEFT)
        BSelect = tk.Button(izbor,text ='Mape',command=mapa)
        BSelect.pack(side = LEFT)
        
        
root = tk.Tk()
root.geometry("300x300")

root.title("Login stranica")

C = Canvas(root, bg ="blue", height = 250, width = 300)
lblfrstrow = tk.Label(root, text ="Ime -", )
lblfrstrow.place(x = 50, y = 20)
username = tk.Entry(root, width = 35)
username.place(x = 150, y = 20, width = 100)
lblsecrow = tk.Label(root, text ="Lozinka -")
lblsecrow.place(x = 50, y = 50)
password = tk.Entry(root, width = 35)
password.place(x = 150, y = 50, width = 100)
submitbtn = tk.Button(root, text ="Prijava",  
                      bg ='blue', command = submitact)
submitbtn.place(x = 150, y = 135, width = 55)
root.mainloop()
