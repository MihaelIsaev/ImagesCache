ImagesCache
===========

ARC only!

ios async downloading uiimageview with blackjack and... cache and scale + retina

just import ImagesCache.h in your .h file of ViewController
```
#import "ImagesCache.h"
```
then create imagesCache object and initialize it in your .m file
```
ImagesCache *imagesCache;
-(void)viewDidLoad
{
  [super viewDidLoad];
  imagesCache = [[ImagesCache alloc] init];
}
```
and in your tableview cell for row at indexpath or other method call imagesCache for get your image from cache or network
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //...initialize your cell
  cell.imageView.image = [imagesCache getImageWithURL:@"http://google.com/logo.png"
                                               prefix:@"catalog_big"
                                                 size:CGSizeMake(100.0f, 100.0f)
                                       forUIImageView:cell.imageView];
  return cell;
}
```
Enjoy! :)



По-русски
===========

Только для проектов с включенным ARC!

Асинхронная загрузка картинок в uiimageview с блэкджеком и... кэшем и ресайзом с учетом ретины

просто импортируем ImagesCache.h в .h файл вашего ViewController'a
```
#import "ImagesCache.h"
```
После этого создаем объект imagesCache в .m файле и инитиализируем его
```
ImagesCache *imagesCache;
-(void)viewDidLoad
{
  [super viewDidLoad];
  imagesCache = [[ImagesCache alloc] init];
}
```
теперь в методе отображения ячейки таблицы или любом другом месте вызываем картинку через imagesCache
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //...инициализируете свою ячейку
  cell.imageView.image = [imagesCache getImageWithURL:@"http://google.com/logo.png"
                                               prefix:@"catalog_big"
                                                 size:CGSizeMake(100.0f, 100.0f)
                                       forUIImageView:cell.imageView];
  return cell;
}
```
Наслаждаемся! :)

