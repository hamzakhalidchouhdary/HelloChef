import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ProductService } from 'src/app/services/product/product.service';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.scss']
})
export class EditProductComponent {
  constructor (private productService: ProductService, private dialogRef: MatDialogRef<EditProductComponent>, @Inject(MAT_DIALOG_DATA) public product: any) {}

  save() :void {
    this.productService.saveProduct(this.product).subscribe(
      (data) => {
        this.dialogRef.close()
      },
      (error) => {
        console.error('error in saving product', error);
      }
    );
    // this.close();
  }

  close() :void {
    console.log('closing dialog');
    this.dialogRef.close();
  }
}
