using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace KP
{
    public static class RCommands
    {
        private static readonly RoutedUICommand MyCommand;

        static RCommands()
        {
            InputGestureCollection gestureCollection = new InputGestureCollection
            {
                new KeyGesture(Key.F1, ModifierKeys.Alt, "F1")
            };//коллекция жестов
            MyCommand = new RoutedUICommand("MyCommand", "MyCommand", typeof(RCommands), gestureCollection);//кидаем в команду
        }
        public static RoutedUICommand myCommand
        {
            get { return MyCommand; }
        }
    }
}
