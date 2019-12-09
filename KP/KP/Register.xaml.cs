using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Data;
using System.Text.RegularExpressions;

namespace KP
{
    /// <summary>
    /// Логика взаимодействия для Page1.xaml
    /// </summary>
    public partial class Register : Page
    {
        private MainWindow mainWindow;
        public Register(MainWindow _mainWindow)
        {
            InitializeComponent();
            mainWindow = _mainWindow;
        }

        private void Button_Reg(object sender, RoutedEventArgs e)
        {
                if (textBox_login.Text.Length > 0) // проверяем логин
                {
                    if (password.Password.Length > 0) // проверяем пароль
                    {
                        if (password_Copy.Password.Length > 0) // проверяем второй пароль
                        {
                            if (password.Password == password_Copy.Password) // проверка на совпадение паролей
                            {
                                DataTable dt_user = mainWindow.Select($"exec [dbo].[CheckReg] '{textBox_login.Text}'");
                                if (dt_user.Rows.Count <= 0)
                                {
                                    string pass = User.HashPassword(password.Password);
                                    //int pass = password.Password.GetHashCode();
                                    mainWindow.Select($"exec [dbo].[CreateUser] '{textBox_login.Text}', '{pass}'");
                                    MessageBox.Show("Пользователь зарегистрирован", "Информация", MessageBoxButton.OK, MessageBoxImage.Asterisk);
                                    mainWindow.OpenPage(MainWindow.pages.login);
                                }
                                else MessageBox.Show("Имя пользователя занято", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                            }
                            else MessageBox.Show("Пароли не совпадают", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                        else MessageBox.Show("Повторите пароль", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                    else MessageBox.Show("Укажите пароль", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else MessageBox.Show("Укажите логин", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
        }
        private void Button_Back(object sender, RoutedEventArgs e)
        {
            mainWindow.OpenPage(MainWindow.pages.login);
        }
        private void TextBox_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            string inputSymbol = e.Text.ToString();
            if (!Regex.Match(inputSymbol, @"[a-zA-zа-яА-Я0-9_,.@$#!*]").Success)
            {
                e.Handled = true;
            }
        }
    }
}
