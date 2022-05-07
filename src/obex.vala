namespace Obex {

[DBus (name = "org.bluez.obex.AgentManager1")]
interface AgentManager: Object {
  public abstract void register_agent(ObjectPath agent) throws GLib.Error;
  public abstract void unregister_agent(ObjectPath agent) throws GLib.Error;
}

[DBus (name = "org.bluez.obex.Session1")]
interface Session: Object {
  public abstract string root { owned get; }
}

[DBus (name = "org.bluez.obex.Transfer1")]
interface Transfer: Object {
  public abstract ObjectPath session { owned get; }
  public abstract uint64 size        { get; }
  public abstract uint64 transferred { get; }
}

[DBus (name = "org.bluez.obex.Agent1")]
public class Agent: Object {
  private DBusConnection conn;

  public Agent(DBusConnection conn) throws GLib.Error {
    this.conn = conn;
  }

  public void release() throws GLib.Error {}
  public void cancel() throws GLib.Error {}

  public string authorize_push(ObjectPath transfer) throws GLib.Error {
    Transfer tx = this.conn.get_proxy_sync(
      "org.bluez.obex", transfer);
    Session ss = this.conn.get_proxy_sync(
      "org.bluez.obex", tx.session);
    var filename = ss.root + "/btftp_example_transfer";

    Timeout.add(
      1000 / 30,
      () => {
        var t = tx.transferred;
        var s = tx.size;
        if (t < s) {
          progress(filename, (double)t / (double)s);
          return true;
        } else {
          done(filename);
          return false;
        }
      });

    progress(filename, 0);
    return filename;
  }

  [DBus (visible = false)]
  public signal void progress(string filename, double ratio);
  [DBus (visible = false)]
  public signal void done(string filename);
}

} // namespace Obex
