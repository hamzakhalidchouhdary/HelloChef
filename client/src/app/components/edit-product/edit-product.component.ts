import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.scss']
})
export class EditProductComponent {
  constructor (private dialogRef: MatDialogRef<EditProductComponent>) {}

  save() :void {
    console.log('product saved');
    this.close();
  }

  close() :void {
    console.log('closing dialog');
    this.dialogRef.close();
  }
}
