import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { NotificationService } from 'src/app/services/notification/notification.service';
import { ProductService } from 'src/app/services/product/product.service';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.scss']
})
export class EditProductComponent {
  constructor (private productService: ProductService, private dialogRef: MatDialogRef<EditProductComponent>, @Inject(MAT_DIALOG_DATA) public product: any, private notificationService: NotificationService) {}

  isSaving: Boolean = false;
  save() :void {
    this.isSaving = true;
    this.productService.saveProduct(this.product).subscribe({
      next: (data) => {
        this.notificationService.showSuccess('Product Updated');
        this.dialogRef.close('SAVED')
      },
      error: (error) => {
        this.isSaving = false;
        this.notificationService.showError('Error in updating Product');
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
        this.notificationService.showSuccess('New Product Added');
        this.dialogRef.close('CREATED')
      },
      error: (error) => {
        this.isSaving = false;
        this.notificationService.showError('Error in creating Product');
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
