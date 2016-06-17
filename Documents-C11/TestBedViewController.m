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
    
    textView.font = [UIFont fontWithName:@"Futura" size:18.0f];
    textView.editable = NO;
}

- (void)showExtensions
{
    int count = 0;  // total
    int count1 = 0; // preferred MIME types
    //int count2 = 0; // Apache
    
    for (NSString *ext in VARIOUS_EXTENSIONS)
    {
        NSString *uti = [UTIHelper preferredUTIForExtension:ext];
        NSString *mime1 = [UTIHelper preferredMimeTypeForUTI:uti];
        //NSString *mime2 = mimeForExtension(ext); // Using Apache
        [self doLog:@"%@: %@ [%@]", ext, uti, mime1];
        //NSLog(@"%@: %@ [%@] [%@]", ext, uti, mime1, mime2);
        count++;
        if (mime1) count1++;
        //if (mime2) count2++;
    }
    
    [self doLog:@"Number of items: %d", count];
    [self doLog:@"Preferred MIME types: %d", count1];
    //[self doLog:@"Apache: %d", count2];
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
