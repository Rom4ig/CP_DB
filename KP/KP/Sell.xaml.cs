using System.ComponentModel;
using System.Data;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace KP
{
    /// <summary>
    /// Логика взаимодействия для Sell.xaml
    /// </summary>
    public partial class Sell : Page
    {
        MainWindow mainWindow;
        public Sell(MainWindow _mainWindow)
        {
            InitializeComponent();
            mainWindow = _mainWindow;
        }

        private void BackP_Click(object sender, RoutedEventArgs e)
        {
            mainWindow.OpenPage(MainWindow.pages.garage);
        }
        private void Tech_Click(object sender, RoutedEventArgs e)
        {
            string type = Tech_Type.Text;
            string cost = Tech_Cost.Text;
            string date = Tech_Date.Text;
            mainWindow.Select($"exec [dbo].[AddTech] {User.car_id}, '{type}', '{date}', {cost}");
            MessageBox.Show("ТО добавлено", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
            Tech_Type.Text = "";
            Tech_Cost.Text = "";
            Tech_Date.Text = "";
        }
        private void Cost_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            string inputSymbol = e.Text.ToString();
            if (!Regex.Match(inputSymbol, @"[0-9*,.]").Success)
            {
                e.Handled = true;
            }
        }
    }
}
