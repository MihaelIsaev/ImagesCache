ImagesCache
===========

ios async uiimageview with cache

just import imagescache in your .h file
```
#import "ImagesCache.h"
```
then create imagescache object and initialize it in your .m file
```
ImagesCache *imagesCache;
-(void)viewDidLoad
{
  [super viewDidLoad];
  imagesCache = [[ImagesCache alloc] init];
}
```
and in your tableview cell for row at indexpath or other method call imagescache for get your image from cache or network
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

