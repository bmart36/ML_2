using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
 

namespace NeuralNet
{
    class _gradient
    {
        public static double f(double x) { return Math.Tanh(Math.Tan(x + Math.Sin(x) / 100)) * x - .7; }
        public static double f_d(double x, double eps) { return (f(x + eps) - f(x)) / eps; } // Appoximated derivated function of f
        public static double zero = 0.001;

        public static void GradEstimation(Graphique G)
        {
            G.ClearWhite();
            DrawFnt(f, Color.Red);
            double x = 0.7;
            double y = f(x);
            G.Cross(x, y, Color.Blue);

            ////////////////////////////////////////////////////////////
            double eps = 0.05;
            double k = 0.01; // Rate of steps
            while(Math.Abs(x) > zero) // Keep trying to find minima that is located in x=0
            {
                x = x - (k * f_d(x, eps)); // x progression towards minima
                y = f(x);
                G.Cross(x, y, Color.Blue);
            }

            ///////////////////////////////////////////////////////
        }


        public static double g(double x) { return x * x - 0.4 * x - 0.5; }
        public static double g_d(double x) { return 2 * x - 0.4; }

        public static void GradLitteral(Graphique G)
        {
            G.ClearWhite();
            DrawFnt(g, Color.Red);
            double x = 1;
            double y = g(x);
            G.Cross(x, y, Color.Blue);

            ///////////////////////////////////////////////////////
            double k = 0.01;
            double y_prev = y;
            while(y <= y_prev) // if y is larger than the previous y, then the minima has already been found
            {
                y_prev = y;
                x = x - (k * g_d(x));
                y = g(x);
                G.Cross(x, y, Color.Blue);
            }
            ///////////////////////////////////////////////////////
        }



        public static double Fnt(double x, double y)
        { return x * x + 0.4 * y * y + 0.2 * x - 0.2 * x * y + 0.1; }
        public static double Fnt_dx(double x, double y)
        { return (2 * x) + 0.2 - (0.2 * y); }
        public static double Fnt_dy(double x, double y)
        { return (0.8 * y) - (0.2 * x); }

        public static void Optim2D(Graphique G)
        {
            G.ClearWhite();
            DrawFnt2D(Fnt);
            G.DrawAxis();

            double x = Utils.RND();
            double y = Utils.RND();
            G.Cross(x, y, Color.White);

            //////////////////////////////////////////////////////
            double k = 0.1;
            double x_prev = 0;
            double y_prev = 0;
            while ((x_prev == 0 && y_prev == 0) || (Math.Abs(x_prev) - Math.Abs(x) > zero || Math.Abs(y_prev) - Math.Abs(y) > zero))
            {
                x_prev = x;
                y_prev = y;
                x = x_prev - (k * Fnt_dx(x_prev, y_prev));
                y = y_prev - (k * Fnt_dy(x_prev, y_prev));
               G.Cross(x, y, Color.White);
            }
         
            //////////////////////////////////////////////////////
        }




        ////////////////////////////////////////////////////////////////

        public static double Fntmax(double x, double y)
        {
            double v1 = x*x + 0.4*y*y + 0.1;
            double v2 = 0.5 * x + 0.4 * y + 0.2;

            return Math.Max(v1, v2);
        }

        public static double Fntmax_dx(double x, double y)
        {
            if (Fntmax(x, y) == (x * x + 0.4 * y * y + 0.1))
                return 2 * x;
            else if (Fntmax(x, y) == (0.5 * x + 0.4 * y + 0.2))
                return 0.5;
            return 0;
        }

        public static double Fntmax_dy(double x, double y)
        {
            if (Fntmax(x, y) == (x * x + 0.4 * y * y + 0.1))
                return 0.8 * y;
            else if (Fntmax(x, y) == (0.5 * x + 0.4 * y + 0.2))
                return 0.4;
            return 0;
        }

        public static void Optim2Dmax(Graphique G)
        {
            G.ClearWhite();
            DrawFnt2D(Fntmax);
            G.DrawAxis();

            double x = Utils.RND();
            double y = Utils.RND();
            G.Cross(x, y, Color.White);

            ///////////////////////////////////////////////////////////////////
            double k = 0.01;
            double x_prev = 0;
            double y_prev = 0;
            while ((x_prev == 0 && y_prev == 0) || (Math.Abs(x_prev) - Math.Abs(x) > zero || Math.Abs(y_prev) - Math.Abs(y) > zero))
            {
                x_prev = x;
                y_prev = y;
                x = x_prev - (k * Fntmax_dx(x_prev, y_prev));
                y = y_prev - (k * Fntmax_dy(x_prev, y_prev));
                G.Cross(x, y, Color.White);
            }
            ///////////////////////////////////////////////////////////////////
        }


        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////

        public delegate double FntX(double x);
        static public void DrawFnt(FntX F, Color c)
        {
            Graphique G = Form1.G;
            for (int xecran = 1; xecran < G.GetH(); xecran++)
            {
                double x = G.XPixToVal(xecran - 1);
                double y = F(x);
                int yecran = G.YValToPix(y);

                double x2 = G.XPixToVal(xecran);
                double y2 = F(x2);
                int yecran2 = G.YValToPix(y2);

                Utils.minmax(ref yecran, ref yecran2);

                for (int yy = yecran; yy <= yecran2; yy++)
                    G.SetPixel(xecran, yy, c);
            }

            G.DrawAxis();
        }

        
        //////////////////////////////////////////////
        
        public delegate double FntXY(double x, double y);


        public static void DrawFnt2D(FntXY Score)
        {
            Graphique G = Form1.G;
            for (int yecran = 0; yecran < G.GetL(); yecran++)
                for (int xecran = 0; xecran < G.GetH(); xecran++)

                {
                    double x = Form1.G.XPixToVal(xecran);
                    double y = Form1.G.YPixToVal(yecran);
                    double s = Score(x, y);
                    Color C = Utils.ScoreToHUE(s);
                    Form1.G.SetPixel(xecran, yecran, C);
                }

        }
    }
}
