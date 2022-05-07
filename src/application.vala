namespace BtftpExample {

public class Application: Adw.Application {
  private Obex.Agent agent;
  private Obex.AgentManager agent_manager;

  public Application() {
    Object(
      application_id: "com.vizio.btftp_example",
      flags: ApplicationFlags.FLAGS_NONE);
  }

  construct {
    ActionEntry[] action_entries = {
      { "about", this.on_about_action },
      {  "quit", this.quit            }
    };

    this.add_action_entries(action_entries, this);
    this.set_accels_for_action("app.quit", {"<primary>q"});
  }

  public override bool dbus_register(DBusConnection conn, string object_path) throws Error {
    base.dbus_register(conn, object_path);

    var agent_path = new ObjectPath(object_path + "/agent");
    this.agent = new Obex.Agent(conn);
    conn.register_object(agent_path, this.agent);

    this.agent.progress.connect(
      (filename, ratio) => {
        var w = (Window)this.active_window;
        if (w != null) w.show_progress(filename, ratio);
      });

    this.agent.done.connect(
      (filename) => {
        var w = (Window)this.active_window;
        if (w != null) w.show_result(filename);
      });

    this.agent_manager =
      conn.get_proxy_sync(
        "org.bluez.obex",
        "/org/bluez/obex");
    this.agent_manager.register_agent(
      agent_path);

    return true;
  }

  public override void activate() {
    base.activate();
    var win = this.active_window;
    if (win == null) {
      win = new BtftpExample.Window(this);
    }
    win.present();
  }

  private void on_about_action() {
    string[] authors = {
      "Vasily Smirnov",
      "vasilii.smirnov@globallogic.com"
    };

    Gtk.show_about_dialog(
      this.active_window,
      "program-name", "btftp_example",
      "authors", authors,
      "version", "0.1.0");
  }
}

} // namespace BtftpExample
