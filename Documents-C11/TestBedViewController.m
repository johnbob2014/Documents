//
//  TestBedViewController.m
//  Documents-C11
//
//  Created by BobZhang on 16/6/17.
//  Copyright © 2016年 ZhangBaoGuo. All rights reserved.
//

#import "TestBedViewController.h"
#import "UIView+AutoLayout.h"
#import "Utility.h"

#pragma mark - TBVC_01_UTI_Utilities

#import "UTIHelper.h"

#define VARIOUS_EXTENSIONS @[@"3dm",@"3dmf",@"a",@"aab",@"aam",@"aas",@"abc",@"acgi",@"afl",@"ai",@"aif",@"aifc",@"aiff",@"aim",@"aip",@"ani",@"aos",@"aps",@"arc",@"arj",@"art",@"asf",@"asm",@"asp",@"asx",@"au",@"avi",@"avs",@"bcpio",@"bin",@"bm",@"bmp",@"boo",@"book",@"boz",@"bsh",@"bz",@"bz2",@"c",@"c++",@"cat",@"cc",@"ccad",@"cco",@"cdf",@"cer",@"cha",@"chat",@"class",@"com",@"conf",@"cpio",@"cpp",@"cpt",@"crl",@"crt",@"csh",@"css",@"cxx",@"dcr",@"deepv",@"def",@"der",@"dif",@"dir",@"dl",@"doc",@"dot",@"dp",@"drw",@"dump",@"dv",@"dvi",@"dwf",@"dwg",@"dxf",@"dxr",@"el",@"elc",@"env",@"eps",@"es",@"etx",@"evy",@"exe",@"f",@"f77",@"f90",@"fdf",@"fif",@"fli",@"flo",@"flx",@"fmf",@"for",@"fpx",@"frl",@"funk",@"g",@"g3",@"gif",@"gl",@"gsd",@"gsm",@"gsp",@"gss",@"gtar",@"gz",@"gzip",@"h",@"hdf",@"help",@"hgl",@"hh",@"hlb",@"hlp",@"hpg",@"hpgl",@"hqx",@"hta",@"htc",@"htm",@"html",@"htmls",@"htt",@"htx",@"ice",@"ico",@"idc",@"ief",@"iefs",@"iges",@"igs",@"ima",@"imap",@"inf",@"ins",@"ip",@"isu",@"it",@"iv",@"ivr",@"ivy",@"jam",@"jav",@"java",@"jcm",@"jfif",@"jfif-tbnl",@"jpe",@"jpeg",@"jpg",@"thm",@"jpg",@"jps",@"js",@"jut",@"kar",@"ksh",@"la",@"lam",@"latex",@"lha",@"lhx",@"list",@"lma",@"log",@"lsp",@"lst",@"lsx",@"ltx",@"lzh",@"lzx",@"m",@"m1v",@"m2a",@"m2v",@"m3u",@"man",@"map",@"mar",@"mbd",@"mc$",@"mcd",@"mcf",@"mcp",@"me",@"mht",@"mhtml",@"mid",@"midi",@"mif",@"mime",@"mjf",@"mjpg",@"mm",@"mme",@"mod",@"moov",@"mov",@"movie",@"mp2",@"mp3",@"mpa",@"mpc",@"mpe",@"mpeg",@"mpg",@"mpga",@"mpp",@"mpt",@"mpv",@"mpx",@"mrc",@"ms",@"mv",@"my",@"mzz",@"nap",@"naplps",@"nc",@"ncm",@"nif",@"niff",@"nix",@"nsc",@"nvd",@"o",@"oda",@"omc",@"omcd",@"omcr",@"p",@"p10",@"p12",@"p7a",@"p7c",@"p7m",@"p7r",@"p7s",@"part",@"pas",@"pbm",@"pcl",@"pct",@"pcx",@"pdb",@"pdf",@"pfunk",@"pgm",@"pic",@"pict",@"pkg",@"pko",@"pl",@"plist",@"plx",@"pm",@"pm4",@"pm5",@"png",@"pnm",@"pot",@"pov",@"ppa",@"ppm",@"pps",@"ppt",@"ppz",@"pre",@"prt",@"ps",@"psd",@"pvu",@"pwz",@"py",@"pyc",@"qcp",@"qd3",@"qd3d",@"qif",@"qt",@"qtc",@"qti",@"qtif",@"ra",@"ram",@"ras",@"rast",@"rexx",@"rf",@"rgb",@"rm",@"rmi",@"rmm",@"rmp",@"rng",@"rnx",@"roff",@"rp",@"rpm",@"rt",@"rtf",@"rtx",@"rv",@"s",@"s3m",@"saveme",@"sbk",@"scm",@"sdml",@"sdp",@"sdr",@"sea",@"set",@"sgm",@"sgml",@"sh",@"shar",@"shtml",@"sid",@"sit",@"skd",@"skm",@"skp",@"skt",@"sl",@"smi",@"smil",@"snd",@"sol",@"spc",@"spl",@"spr",@"sprite",@"src",@"ssi",@"ssm",@"sst",@"step",@"stl",@"stp",@"sv4cpio",@"sv4crc",@"svf",@"svr",@"swf",@"t",@"talk",@"tar",@"tbk",@"tcl",@"tcsh",@"tex",@"texi",@"texinfo",@"text",@"tgz",@"tif",@"tiff",@"tr",@"tsi",@"tsp",@"tsv",@"turbot",@"txt",@"uil",@"uni",@"unis",@"unv",@"uri",@"uris",@"ustar",@"uu",@"uue",@"vcd",@"vcs",@"vda",@"vdo",@"vew",@"viv",@"vivo",@"vmd",@"vmf",@"voc",@"vos",@"vox",@"vqe",@"vqf",@"vql",@"vrml",@"vrt",@"vsd",@"vst",@"vsw",@"w60",@"w61",@"w6w",@"wav",@"wb1",@"wbmp",@"web",@"wiz",@"wk1",@"wmf",@"wml",@"wmlc",@"wmls",@"wmlsc",@"word",@"wp",@"wp5",@"wp6",@"wpd",@"wq1",@"wri",@"wrl",@"wrz",@"wsc",@"wsrc",@"wtk",@"xbm",@"xdr",@"xgz",@"xif",@"xl",@"xla",@"xlb",@"xlc",@"xld",@"xlk",@"xll",@"xlm",@"xls",@"xlt",@"xlv",@"xlw",@"xm",@"xml",@"xmz",@"xpix",@"xpm",@"x-png",@"xsr",@"xwd",@"xyz",@"z",@"zip",@"zoo",@"zsh"]

@implementation TBVC_01_UTI_Utilities{
    UITextView *textView;
    NSMutableString *logMS;
}

- (void)loadView{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Ext", @selector(showExtensions));
    
    textView = [UITextView newAutoLayoutView];
    [self.view addSubview:textView];
    [textView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    textView.font = [UIFont fontWithName:@"Futura" size:10.0f];
    textView.editable = NO;
}

- (void)showExtensions
{
    int count = 0;  // total
    int count1 = 0; // preferred MIME types
    int count2 = 0; // Apache
    
    for (NSString *ext in VARIOUS_EXTENSIONS)
    {
        NSString *uti = [UTIHelper preferredUTIForExtension:ext];
        NSString *mime1 = [UTIHelper preferredMimeTypeForUTI:uti];
        NSString *mime2 = [UTIHelper mimeForExtension:ext]; // Using Apache
        [self doLog:@"%@ - [UTI]:%@ [MIME]:%@ %@", ext, uti, mime1 ,mime2];
        //NSLog(@"%@: %@ [%@] [%@]", ext, uti, mime1, mime2);
        count++;
        if (mime1) count1++;
        if (mime2) count2++;
    }
    
    [self doLog:@"Number of items: %d", count];
    [self doLog:@"Preferred MIME types: %d", count1];
    [self doLog:@"Apache: %d", count2];
}

- (void)doLog:(NSString *)formatstring, ...
{
    if (!formatstring) return;
    
    va_list arglist;
    va_start(arglist, formatstring);
    NSString *outstring = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    
    if (!logMS) logMS = [NSMutableString string];
    
    //NSLog(@"%@", outstring);
    
    [logMS appendString:outstring];
    [logMS appendString:@"\n"];
    textView.text = logMS;
}

@end

#pragma mark - TBVC_03_Document_Monitoring

#import "DocumentWatcher.h"

@implementation TBVC_03_Document_Monitoring{
    NSArray *itemArray;
    DocumentWatcher *watcher;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self scanDocuments];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kDocumentChanged object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification)
     {
         // Contents changed
         [self scanDocuments];
     }];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    watcher = [DocumentWatcher documentWatcherForPath:path];
}

- (void)scanDocuments
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    itemArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    [self.tableView reloadData];
}

// Number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 1;
}

// Rows per section
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return itemArray.count;
}

// Return a cell for the index path
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [itemArray objectAtIndex:indexPath.row];
    return cell;
}

@end

#pragma mark - TBVC_04_UIActivityViewController

@interface CustomActivity : UIActivity
@end

@implementation CustomActivity

- (NSString *)activityType{
    return @"CustomActivityTypeListItemsAndTypes";
}

- (NSString *)activityTitle{
    return @"CTP";
}

- (UIImage *)activityImage{
    CGFloat targetSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 57 : 72;
    CGFloat inset = targetSize * 0.15;
    CGRect rect = CGRectMake(0, 0, targetSize, targetSize);
    
    UIGraphicsBeginImageContext(rect.size);
    CGRect smallRect = CGRectInset(rect, inset, inset);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10.0f];
    [[UIColor blueColor] setStroke];
    [path stroke];
    
    [@"CTP" drawInRect:smallRect withAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Futura" size:30]}];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems{
    
}

- (UIViewController *)activityViewController{
    UIViewController *customVC = [UIViewController new];
    
    customVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStylePlain target:self action:@selector(okAction)];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:customVC];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    return nav;
}

- (void)okAction{
    [self activityDidFinish:YES];
}

@end

@interface TBVC_04_UIActivityViewController ()
@end

@implementation TBVC_04_UIActivityViewController{
    UIActivityViewController *activityVC;
    UISegmentedControl *seg;
    UIImageView *imageView;
}

- (void)loadView{
    self.view = [UIView new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action:)];
    
    seg = [[UISegmentedControl alloc] initWithItems:[@"System Custom" componentsSeparatedByString:@" "]];
    seg.selectedSegmentIndex = 1;
    self.navigationItem.titleView = seg;
    
    imageView = [UIImageView newAutoLayoutView];
    imageView.image = [UIImage imageNamed:@"CoverArt"];
    [self.view addSubview:imageView];
    [imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

- (void)action:(id)sender{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self systemActivity];
            break;
        case 1:
            [self customActivity];
            break;
            
        default:
            break;
    }
}

- (void)systemActivity{
    activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[imageView.image] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)customActivity{
    activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[imageView.image] applicationActivities:@[[CustomActivity new]]];
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end

#pragma mark - TBVC_05_QuickLook_QLPreviewController

@import QuickLook;

@interface CustomQLPreviewItem : NSObject <QLPreviewItem>
@property (nonatomic,strong) NSString *previewItemPath;
@end

@implementation CustomQLPreviewItem

- (NSURL *)previewItemURL{
    return [NSURL fileURLWithPath:self.previewItemPath];
}

- (NSString *)previewItemTitle{
    return [self.previewItemPath lastPathComponent];
}

@end

#define FILE_PATH   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/PDFSample.pdf"]

@interface TBVC_05_QuickLook_QLPreviewController ()<QLPreviewControllerDataSource>
@end

@implementation TBVC_05_QuickLook_QLPreviewController

- (void)loadView{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Push", @selector(push));
    self.navigationItem.leftBarButtonItem = BARBUTTON(@"Present", @selector(present));
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:FILE_PATH]) [self createPDF];
}

- (void)push{
    QLPreviewController *controller = [[QLPreviewController alloc] init];
    controller.dataSource = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)present{
    QLPreviewController *controller = [[QLPreviewController alloc] init];
    controller.dataSource = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)createPDF{
    // Create a string
    NSMutableParagraphStyle *mPS = [[NSMutableParagraphStyle alloc] init];
    mPS.alignment = NSTextAlignmentCenter;
    NSDictionary *attributesDic = @{ NSParagraphStyleAttributeName : mPS,
                                     NSFontAttributeName : [UIFont fontWithName:@"Arial-BoldMT" size:36.0f],
                                     NSForegroundColorAttributeName : [UIColor redColor]};
    NSMutableAttributedString *mAS = [[NSMutableAttributedString alloc] initWithString:@"Qucik Look Demo" attributes:attributesDic];
    
    // Load an image
    UIImage *image = [UIImage imageNamed:@"CoverArt"];
    
    // Create PDF
    CGRect rect = CGRectMake(0, 0, 480, 600);
    UIGraphicsBeginPDFContextToFile(FILE_PATH, rect, nil);
    UIGraphicsBeginPDFPage();
    [mAS drawInRect:CGRectMake(0, 30, 480, 50)];
    [image drawAtPoint:CGPointMake(10, 80)];
    UIGraphicsEndPDFContext();
}

#pragma mark QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 2;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    CustomQLPreviewItem *item = [CustomQLPreviewItem new];
    if ( index == 0) {
        item.previewItemPath = FILE_PATH;
    }else if ( index == 1){
        item.previewItemPath = [[NSBundle mainBundle] pathForResource:@"爸爸QQ号 3147261707" ofType:@"txt"];
    }
    
    return item;
}
@end

#pragma mark - TBVC_06_UIDocumentInteractionController

@interface TBVC_06_UIDocumentInteractionController () <UIDocumentInteractionControllerDelegate>
@end

@implementation TBVC_06_UIDocumentInteractionController{
    UIDocumentInteractionController *demoDIC;
    NSURL *fileURL;
    BOOL canOpen;
}

- (void)loadView{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Open in...", @selector(open:));
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action:)];
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CustomImage.png"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"CoverArt"]);
        [imageData writeToFile:filePath atomically:YES];
    }
    fileURL = [NSURL fileURLWithPath:filePath];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    canOpen = [self canOpen:fileURL];
    self.navigationItem.rightBarButtonItem.enabled = canOpen;
}

- (BOOL)canOpen:(NSURL *)aFileURL{
    UIDocumentInteractionController *tmp = [UIDocumentInteractionController interactionControllerWithURL:aFileURL];
    BOOL success = [tmp presentOpenInMenuFromRect:CGRectMake(0, 0, 100, 100) inView:self.view animated:NO];
    [tmp dismissMenuAnimated:NO];
    return success;
}

- (void)open:(UIBarButtonItem *)sender{
    [self dismissIfNeeded];
    demoDIC = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    demoDIC.delegate = self;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [demoDIC presentOpenInMenuFromBarButtonItem:sender animated:YES];
}

- (void)action:(UIBarButtonItem *)sender{
    [self dismissIfNeeded];
    demoDIC = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    demoDIC.delegate = self;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    [demoDIC presentOptionsMenuFromBarButtonItem:sender animated:YES];
}

- (void)dismissIfNeeded{
    if (demoDIC) {
        [demoDIC dismissMenuAnimated:YES];
        self.navigationItem.rightBarButtonItem.enabled = canOpen;
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
}

#pragma mark UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.frame;
}

- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    demoDIC = nil;
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    self.navigationItem.rightBarButtonItem.enabled = canOpen;
    demoDIC = nil;
}
@end

#pragma mark - TBVC_07_Receive_Process_CustomType_Documents

#define DOCUMENTS_PATH  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define INBOX_PATH      [DOCUMENTS_PATH stringByAppendingPathComponent:@"Inbox"]

@interface TBVC_07_Receive_Process_CustomType_Documents () <QLPreviewControllerDataSource>
@end

@implementation TBVC_07_Receive_Process_CustomType_Documents{
    NSArray *docArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"generic"];
    [self scanDocs];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath)
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scanDocs
{
    docArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:DOCUMENTS_PATH error:nil];
    [self.tableView reloadData];
}

#pragma mark UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return docArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"generic" forIndexPath:indexPath];
    cell.textLabel.text = [docArray objectAtIndex:indexPath.row];
    return cell;
}

// Support swipe-to-delete
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= (NSInteger) docArray.count)
    {
        // Catch Bug Here
        NSLog(@"System Inconsistency. Requested row %d", indexPath.row);
        return;
    }
    
    // Tried to avoid holding onto that cell -- didn't change the bug
    NSString *title = [[[self tableView:self.tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    NSString *path = [DOCUMENTS_PATH stringByAppendingPathComponent:title];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSError *error;
        if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error])
            NSLog(@"Error deleting item %@: %@", path, error.localizedFailureReason);
    }
    
    [self scanDocs];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QLPreviewController *controller = [[QLPreviewController alloc] init];
    controller.dataSource = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *fileName = docArray[indexPath.row];
    NSString *filePath = [DOCUMENTS_PATH stringByAppendingPathComponent:fileName];
    return [NSURL fileURLWithPath:filePath];
}
@end