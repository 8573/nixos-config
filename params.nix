{ local-installation, params, ... }: {

secure = false;
lightweight = false;

use-grsecurity = params.secure;

use-X11 = local-installation.type != "server";
use-i3 = params.use-X11 && !params.use-KDE;
use-KDE = false;

get-i3 = params.use-X11 && (params.use-i3 || !params.lightweight);
get-KDE = params.use-X11 && (params.use-KDE || (!params.lightweight && local-installation.type == "desktop"));

enable-all-firmware = !params.lightweight || local-installation.type != "server";

}
