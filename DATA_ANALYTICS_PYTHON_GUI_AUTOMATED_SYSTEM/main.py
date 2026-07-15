import customtkinter as ctk
from customtkinter import filedialog
import tkinter as tk
from tkinter import simpledialog
from tkinter import ttk

# Import our custom engines
from core.excel_engine import load_data, action_drop_empty, action_clean_headers, save_data
from core.db_engine import run_sqlite_query
import pandas as pd

# Set appearance mode and color theme
ctk.set_appearance_mode("System")  # Modes: "System" (standard), "Dark", "Light"
ctk.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"

class App(ctk.CTk):
    def __init__(self):
        super().__init__()

        # Current working data
        self.current_df = None
        self.original_filepath = None

        # configure window
        self.title("Data Analytics Automated System")
        self.geometry(f"{1000}x700")

        # configure grid layout (4x4)
        self.grid_columnconfigure(1, weight=1)
        self.grid_columnconfigure((2, 3), weight=0)
        self.grid_rowconfigure((0, 1, 2), weight=1)

        # create sidebar frame with widgets
        self.sidebar_frame = ctk.CTkFrame(self, width=160, corner_radius=0)
        self.sidebar_frame.grid(row=0, column=0, rowspan=4, sticky="nsew")
        self.sidebar_frame.grid_rowconfigure(5, weight=1)
        
        self.logo_label = ctk.CTkLabel(self.sidebar_frame, text="DA System", font=ctk.CTkFont(size=20, weight="bold"))
        self.logo_label.grid(row=0, column=0, padx=20, pady=(20, 10))
        
        self.sidebar_button_1 = ctk.CTkButton(self.sidebar_frame, text="Load Excel File", command=self.load_excel_event)
        self.sidebar_button_1.grid(row=1, column=0, padx=20, pady=10)
        
        self.sidebar_button_2 = ctk.CTkButton(self.sidebar_frame, text="Database Query", command=self.db_event)
        self.sidebar_button_2.grid(row=2, column=0, padx=20, pady=10)
        
        self.sidebar_button_3 = ctk.CTkButton(self.sidebar_frame, text="Power BI Sync", command=self.pbi_event)
        self.sidebar_button_3.grid(row=3, column=0, padx=20, pady=10)
        
        self.appearance_mode_label = ctk.CTkLabel(self.sidebar_frame, text="Appearance Mode:", anchor="w")
        self.appearance_mode_label.grid(row=6, column=0, padx=20, pady=(10, 0))
        self.appearance_mode_optionemenu = ctk.CTkOptionMenu(self.sidebar_frame, values=["Light", "Dark", "System"],
                                                                       command=self.change_appearance_mode_event)
        self.appearance_mode_optionemenu.grid(row=7, column=0, padx=20, pady=(10, 20))
        self.appearance_mode_optionemenu.set("System")

        # create main frame layout
        self.main_frame = ctk.CTkFrame(self, fg_color="transparent")
        self.main_frame.grid(row=0, column=1, rowspan=4, columnspan=3, sticky="nsew", padx=10, pady=10)
        self.main_frame.grid_columnconfigure(0, weight=1)
        self.main_frame.grid_rowconfigure(1, weight=1) # The grid takes the space
        self.main_frame.grid_rowconfigure(2, weight=0) # Tools take less

        self.header_label = ctk.CTkLabel(self.main_frame, text="Workspace Data Preview", font=ctk.CTkFont(size=20, weight="bold"))
        self.header_label.grid(row=0, column=0, padx=10, pady=(10,0), sticky="w")

        # Create Treeview inside a frame for scrollbars
        self.tree_frame = ctk.CTkFrame(self.main_frame)
        self.tree_frame.grid(row=1, column=0, padx=10, pady=10, sticky="nsew")
        self.tree_frame.grid_columnconfigure(0, weight=1)
        self.tree_frame.grid_rowconfigure(0, weight=1)

        # Style the treeview to look modern
        style = ttk.Style()
        style.theme_use("default")
        style.configure("Treeview", 
                        background="#2a2d2e",
                        foreground="white",
                        rowheight=25,
                        fieldbackground="#343638",
                        bordercolor="#343638",
                        borderwidth=0)
        style.map('Treeview', background=[('selected', '#22559b')])
        style.configure("Treeview.Heading",
                        background="#565b5e",
                        foreground="white",
                        relief="flat",
                        font=('Calibri', 10, 'bold'))
        style.map("Treeview.Heading", background=[('active', '#3484F0')])

        self.tree = ttk.Treeview(self.tree_frame, selectmode='browse')
        self.tree.grid(row=0, column=0, sticky="nsew")

        self.vsb = ttk.Scrollbar(self.tree_frame, orient="vertical", command=self.tree.yview)
        self.vsb.grid(row=0, column=1, sticky="ns")
        self.hsb = ttk.Scrollbar(self.tree_frame, orient="horizontal", command=self.tree.xview)
        self.hsb.grid(row=1, column=0, sticky="ew")
        self.tree.configure(yscrollcommand=self.vsb.set, xscrollcommand=self.hsb.set)

        # Action Panel (Hidden by default, shown when excel is loaded)
        self.action_frame = ctk.CTkFrame(self.main_frame)
        self.action_frame.grid(row=2, column=0, padx=10, pady=10, sticky="nsew")
        
        self.action_label = ctk.CTkLabel(self.action_frame, text="Excel Actions:")
        self.action_label.pack(side="left", padx=10)
        
        self.btn_empty = ctk.CTkButton(self.action_frame, text="Drop Empty Rows", command=self.do_drop_empty, state="disabled")
        self.btn_empty.pack(side="left", padx=5, pady=10)
        
        self.btn_head = ctk.CTkButton(self.action_frame, text="Clean Headers", command=self.do_clean_headers, state="disabled")
        self.btn_head.pack(side="left", padx=5, pady=10)
        
        self.btn_save = ctk.CTkButton(self.action_frame, text="Save Data As...", command=self.do_save, fg_color="green", hover_color="darkgreen", state="disabled")
        self.btn_save.pack(side="right", padx=10, pady=10)

        self.status_label = ctk.CTkLabel(self.main_frame, text="Status: Ready", text_color="gray")
        self.status_label.grid(row=3, column=0, padx=10, pady=5, sticky="w")

    def change_appearance_mode_event(self, new_appearance_mode: str):
        ctk.set_appearance_mode(new_appearance_mode)
        # Tkinter treeview styling might need re-applying for light mode, skipping for brevity

    def set_status(self, message):
        self.status_label.configure(text=f"Status: {message}")

    def update_treeview(self):
        """Updates the GUI grid with current_df data"""
        # Clear existing items
        self.tree.delete(*self.tree.get_children())
        
        if self.current_df is not None:
            # Set columns
            cols = list(self.current_df.columns)
            self.tree["columns"] = cols
            self.tree["show"] = "headings"
            
            for col in cols:
                self.tree.heading(col, text=col)
                self.tree.column(col, width=100, minwidth=50)
            
            # Insert max 500 rows for performance preview
            preview_df = self.current_df.head(500)
            for i, row in preview_df.iterrows():
                self.tree.insert("", "end", values=list(row))
            
            self.set_status(f"Previewing {len(preview_df)} of {len(self.current_df)} rows.")
            
            # Enable buttons
            self.btn_empty.configure(state="normal")
            self.btn_head.configure(state="normal")
            self.btn_save.configure(state="normal")

    def load_excel_event(self):
        filepath = filedialog.askopenfilename(
            title="Select an Excel File",
            filetypes=[("Excel files", "*.xlsx *.xls")]
        )
        if filepath:
            self.set_status(f"Loading {filepath}...")
            df, msg = load_data(filepath)
            if df is not None:
                self.current_df = df
                self.original_filepath = filepath
                self.update_treeview()
                self.set_status(msg)
            else:
                self.set_status(msg)

    def do_drop_empty(self):
        if self.current_df is not None:
            self.current_df, msg = action_drop_empty(self.current_df)
            self.update_treeview()
            self.set_status(msg)

    def do_clean_headers(self):
        if self.current_df is not None:
            self.current_df, msg = action_clean_headers(self.current_df)
            self.update_treeview()
            self.set_status(msg)

    def do_save(self):
        if self.current_df is not None:
            filepath = filedialog.asksaveasfilename(
                defaultextension=".xlsx",
                filetypes=[("Excel files", "*.xlsx")],
                title="Save cleaned file as"
            )
            if filepath:
                success, msg = save_data(self.current_df, filepath)
                self.set_status(msg)

    def db_event(self):
        filepath = filedialog.askopenfilename(
            title="Select a SQLite Database File",
            filetypes=[("SQLite DB", "*.db *.sqlite"), ("All files", "*.*")]
        )
        if filepath:
            query = simpledialog.askstring("Enter SQL Query", "Enter your SELECT query:", parent=self)
            if query:
                self.set_status(f"Executing query...")
                success, message = run_sqlite_query(filepath, query)
                tk.messagebox.showinfo("Database Query Result", message)
            else:
                self.set_status("Query entry cancelled.")

    def pbi_event(self):
        self.set_status("Power BI Sync module activated. (Coming Soon!)")

if __name__ == "__main__":
    app = App()
    app.mainloop()
