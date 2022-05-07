namespace BtftpExample {

[GtkTemplate (ui = "/com/vizio/btftp_example/window.ui")]
public class Window: Gtk.ApplicationWindow {
  [GtkChild]
  private unowned Gtk.Stack stack;
  [GtkChild]
  private unowned Gtk.Image logo;
  [GtkChild]
  private unowned Gtk.ProgressBar progress;

  public Window(Gtk.Application app) {
    Object(application: app);
  }

  public void show_progress(string label, double ratio) {
    this.progress.text = label;
    this.progress.show_text = true;
    this.progress.fraction = ratio;
    this.stack.visible_child = this.progress;
  }

  public void show_result(string image) {
    this.logo.set_from_file(image);
    this.stack.set_visible_child(this.logo);
  }
}

} // namespace BtftpExample
