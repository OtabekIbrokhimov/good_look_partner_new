abstract class MainScreenEvent {}

class MenuClickEvent extends MainScreenEvent {
  final int selectedIndex;

  MenuClickEvent(this.selectedIndex);
}
