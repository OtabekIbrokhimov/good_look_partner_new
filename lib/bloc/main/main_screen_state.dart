abstract class MainScreenState {}

class InitialMainScreenState extends MainScreenState {}

class MenuChangeMainScreenState extends MainScreenState {
  final int selectedIndex;

  MenuChangeMainScreenState(this.selectedIndex);
}
