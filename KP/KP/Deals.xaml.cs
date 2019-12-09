using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace KP
{
    /// <summary>
    /// Логика взаимодействия для Deals.xaml
    /// </summary>
    public partial class Deals : Page
    {
        MainWindow mainWindow;
        public Deals(MainWindow _mainWindow)
        {
            InitializeComponent();
            mainWindow = _mainWindow;
            Refresh();
        }

        private void DataGrid_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            PropertyDescriptor propertyDescriptor = (PropertyDescriptor)e.PropertyDescriptor;
            e.Column.Header = propertyDescriptor.DisplayName;
            if (propertyDescriptor.DisplayName == "Id" || propertyDescriptor.DisplayName == "IdCar" || propertyDescriptor.DisplayName=="Cd")
            {
                e.Cancel = true;
            }
        }
        private void Refresh()
        {
            DataTable dataTable = mainWindow.Select($"[dbo].[SelectTechCar] {User.car_id}");
            List_Deals.ItemsSource = dataTable.DefaultView;
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            mainWindow.OpenPage(MainWindow.pages.garage);
        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            if (List_Deals.SelectedItem != null)
            {
                string ID = ((DataRowView)List_Deals.SelectedItems[0]).Row["Id"].ToString();
                mainWindow.Select($"[dbo].[DeleteTech] {ID}");
                MessageBox.Show("Успешно удалено", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
                Refresh();
            }
            else MessageBox.Show("Выберите ТО", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
