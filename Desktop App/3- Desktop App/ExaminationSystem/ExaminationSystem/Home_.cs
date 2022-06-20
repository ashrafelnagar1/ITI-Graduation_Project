using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ExaminationSystem
{
    public partial class Home_ : Form
    {
        public Home_()
        {
            InitializeComponent();
        }

        private void btnStudent_Click(object sender, EventArgs e)
        {
            this.Hide();
            new Login().ShowDialog();
            this.Show();
        }


        private void btnInstructor_Click_1(object sender, EventArgs e)
        {
            this.Hide();
            new Login_Ins().ShowDialog();
            this.Show();

        }

        private void btnabout_Click_1(object sender, EventArgs e)
        {
            MessageBox.Show("AUTHORS\n----------------\n\n-Nada Ellithy\n-Khaled Eleraeky\n-Ashraf Alnagar\n-Heba Hammad\n\nCopyrights© 2022",
               "About Us", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void btnExit_Click_1(object sender, EventArgs e)
        {

            this.Close();
        }

        private void Home__FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Are you want to close the App?", "Exit", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
            {
                e.Cancel = true;
               
            }
        }
    }
}
