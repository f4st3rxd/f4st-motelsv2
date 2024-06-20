# f4st motelsv2

f4st motelsv2, FiveM için geliştirilmiş bir scripttir. Oyuncuların oyun içinde motellerde kalmasını sağlar ve kolay konfigürasyon, optimizasyon ve oda özelleştirme imkanı sunar.
f4st motelsv2 is a script developed for FiveM. It allows players to stay at motels in the game and provides tools for easy configuration, optimization, and room customization.

## Özellikler / Features

- **Motel Teleport / Teleport to Motel**: Oyuncuları hızlıca motel odalarına teleport eder. / Quickly teleport players to their motel rooms.
- **Kolay Konfigürasyon / Easy Configuration**: Sağlanan ayar dosyalarıyla motelleri kolayca özelleştirebilirsiniz. / Customize motels easily using provided configuration files.
- **Optimize Edilmiş Script / Optimized Script**: Performans optimizasyonu için tasarlanmıştır. / Designed for performance optimization.
- **Özelleştirilebilir Odalar / Customizable Rooms**: Her odayı belirli özellikler ve ayarlarla özelleştirebilirsiniz. / Customize each room with specific features and settings.
- **ox inventory ve qb inventory Desteği / ox inventory and qb inventory Support**: Oyuncuların envanter sistemine uyumludur, ox inventory ve qb inventory destekler. / Compatible with player inventory systems, supporting ox inventory and qb inventory.

## Gereksinimler / Requirements

- [QBCore](https://github.com/qbcore-framework/qb-core)
- [oxmysql](https://github.com/overextended/oxmysql)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)

## Kurulum / Installation

1. **SQL Dosyası / SQL File**: İlk olarak `sql` klasöründeki SQL dosyasını veritabanınıza yükleyin. / Import the SQL file from the `sql` folder into your database.
   
2. **Map Dosyası / Map File**: `motelmap` klasöründeki harita dosyasını sunucunuzdaki uygun konuma ekleyin (`motelmap`). / Place the map file (`motelmap`) from the `map` folder in the appropriate location on your server.

3. **Script Kurulumu / Script Installation**: Sunucunuzun `resources` klasörüne `f4st_motelsv2` adında bir klasör oluşturun ve script dosyalarını bu klasörün içine ekleyin. / Create a folder named `f4st_motelsv2` in your server's `resources` folder and add the script files there.

4. **Gereksinimlerin Yüklenmesi / Installing Requirements**: Yukarıda belirtilen gereksinimleri indirip sunucunuza ekleyin. / Download and add the required resources listed above to your server.

5. **server.cfg Ayarları / server.cfg Configuration**: Sunucunuzun `server.cfg` dosyasına `ensure f4st-motelsv2` satırını ekleyerek scripti başlatın. / Add `ensure f4st-motelsv2` to your `server.cfg` file to start the script.

6. **If you are using a different language, you need to translate it into Turkish**

## Kullanım / Usage

- Oyuna girdiğinizde, menüler aracılığıyla motelleri yönetebilirsiniz. / Once in-game, manage motels using menus.
- Motellerin ayarlarını ve özelliklerini scriptin içindeki dosyalardan düzenleyebilirsiniz. / Customize motel settings and features by editing the provided files within the script.

Preview : https://www.youtube.com/watch?v=rKd80hBV7-A
