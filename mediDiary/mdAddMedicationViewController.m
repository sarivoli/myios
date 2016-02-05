//
//  mdAddMedicationViewController.m
//  mediDiary
//
//  Created by Arivoli on 10/9/13.
//  Copyright (c) 2013 Arivoli. All rights reserved.
//

#import "mdAddMedicationViewController.h"

@interface mdAddMedicationViewController ()

@end

@implementation mdAddMedicationViewController
@synthesize txtName,txtUse,segFood,visitId,btnA,btnE,btnM,btnN,imgMedication,imgSelected;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [btnM setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [btnA setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
     [btnE setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
     [btnN setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    self.imgSelected = FALSE;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveMedication{
    mdDiary *md=[[mdDiary alloc]init];
    //NSDictionary *timeFrame = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"BF","AF","EM", nil] forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2", nil]];
    NSDictionary *timeFrame = [NSDictionary dictionaryWithObjects:@[@"BF",@"AF",@"EM"] forKeys:@[@"0",@"1",@"2"]];
    
    
    NSMutableDictionary *medicationInfo=[[NSMutableDictionary alloc]init];
    [medicationInfo setObject:visitId  forKey:@"visitid"];
    [medicationInfo setObject:[txtName text]  forKey:@"name"];
    

    [medicationInfo setObject: [txtUse text] forKey:@"use"];
    NSString *freq =[[NSString alloc] init];
 
    freq =[NSString stringWithFormat:@"%u-%u-%u-%u",(unsigned int)[btnM state],(unsigned int)[btnA state],(unsigned int)[btnE state],(unsigned int)[btnN state]];
    freq=[freq stringByReplacingOccurrencesOfString:@"4" withString:@"1"];
    
    [medicationInfo setObject:freq forKey:@"freq"];
    NSLog(@"selected food %@",[NSString stringWithFormat:@"%li",(long)[segFood selectedSegmentIndex]]);
    
    [medicationInfo setObject:[timeFrame objectForKey:[NSString stringWithFormat:@"%li",(long)[segFood selectedSegmentIndex]]] forKey:@"food"];
    //Storing image if user taken any
    if(self.imgSelected){
        NSString *imagePath = [md saveImage:self.imgMedication.image imageFileNamePrefix:[NSString stringWithFormat:@"medication_%@",visitId]];
        [medicationInfo setObject:imagePath forKey:@"image"];
        NSLog(@"Image has been stored at the location %@",imagePath);
    }else{
        [medicationInfo setObject:@"" forKey:@"image"];

    }
    
 
    
   [md addMedications:medicationInfo];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Successfully Saved %@",medicationInfo);
    
}

-(IBAction)btnClicked:(UIButton*)sender{
    sender.selected=!sender.selected;
    
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
     self.imgSelected = TRUE;
    [self.imgMedication setImage:chosenImage];
    
    //    self.imgMedication.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)takePhotos:(id)sender {
    UIImagePickerController *picker;
    
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
        {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        } else
            
            {
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            }
    picker.delegate = self;
    picker.allowsEditing = YES;
    // picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
    // [self presentModalViewController:picker animated:YES];
}


    


@end
