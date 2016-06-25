{ local-installation, params, ... }: {

secure = false;
lightweight = false;

use-grsecurity = params.secure;

use-X11 = false;
use-i3 = params.use-X11 && !params.use-KDE;
use-KDE = false;

get-i3 = params.use-X11 && (params.use-i3 || !params.lightweight);
get-KDE = params.use-X11 && (params.use-KDE || !params.lightweight);

enable-all-firmware = !params.lightweight;

}
