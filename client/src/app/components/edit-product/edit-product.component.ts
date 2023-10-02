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

  isSaving: Boolean = false;
  save() :void {
    this.isSaving = true;
    this.productService.saveProduct(this.product).subscribe({
      next: (data) => {
        this.dialogRef.close('SAVED')
      },
      error: (error) => {
        console.error('error in saving product', error);
      },
      complete: () => {       
        this.isSaving = false;
      }
    });
  }

  create(): void {
    this.isSaving = true;
    this.productService.createProduct(this.product).subscribe({
      next: (data) => {
        this.product.id = data.items.id
        this.dialogRef.close('CREATED')
      },
      error: (error) => {
        this.isSaving = false;
        console.error('error in creating product', error);
      },
      complete: () => {
        this.isSaving = false;
      }
    });
  }

  close() :void {
    this.dialogRef.close('DISCARDED');
  }
}
