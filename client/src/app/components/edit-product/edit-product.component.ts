import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.scss']
})
export class EditProductComponent {
  constructor (private dialogRef: MatDialogRef<EditProductComponent>, @Inject(MAT_DIALOG_DATA) public product: any) {}

  save() :void {
    console.log('product saved');
    this.close();
  }

  close() :void {
    console.log('closing dialog');
    this.dialogRef.close();
  }
}
