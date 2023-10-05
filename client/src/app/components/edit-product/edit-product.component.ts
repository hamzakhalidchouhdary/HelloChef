import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { NotificationService } from 'src/app/services/notification/notification.service';
import { ProductService } from 'src/app/services/product/product.service';
import {COMMA, ENTER} from '@angular/cdk/keycodes';
import { MatChipInputEvent, MatChipEditedEvent } from '@angular/material/chips';
import Product from 'src/app/models/product.model';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.scss'],
})
export class EditProductComponent {
  constructor(
    private productService: ProductService,
    private dialogRef: MatDialogRef<EditProductComponent>,
    @Inject(MAT_DIALOG_DATA) public product: Product,
    private notificationService: NotificationService
  ) { }

  isSaving: Boolean = false;
  readonly separatorKeysCodes = [ENTER, COMMA] as const;
  save(): void {
    this.isSaving = true;
    this.productService.saveProduct(this.product).subscribe({
      next: (data) => {
        this.notificationService.showSuccess('Product Updated');
        this.dialogRef.close('SAVED');
      },
      error: (error) => {
        this.isSaving = false;
        this.notificationService.showError('Error in updating Product');
      },
      complete: () => {
        this.isSaving = false;
      },
    });
  }

  create(): void {
    this.isSaving = true;
    this.productService.createProduct(this.product).subscribe({
      next: (data) => {
        this.product.id = data.items.id;
        this.notificationService.showSuccess('New Product Added');
        this.dialogRef.close('CREATED');
      },
      error: (error) => {
        this.isSaving = false;
        this.notificationService.showError('Error in creating Product');
      },
      complete: () => {
        this.isSaving = false;
      },
    });
  }

  addProductLabel(event: MatChipInputEvent): void {
    const value = (event.value || '').trim();

    // Add our label
    if (value) {
      if (!this.product.labels) this.product.labels = [];
      this.product.labels.push(value);
    }

    // Clear the input value
    event.chipInput!.clear();
  }

  removeProductLabel(label: string): void {
    const index = this.product.labels.indexOf(label);
    if (index >= 0) this.product.labels.splice(index, 1);
  }

  editProductLabel(label: string, event: MatChipEditedEvent) {
    const value = event.value.trim();

    // Remove label if it no longer has a name
    if (!value) {
      this.removeProductLabel(label);
      return;
    }

    // Edit existing label
    const index = this.product.labels.indexOf(label);
    if (index >= 0) {
      this.product.labels[index] = value;
    }
  }

  close(): void {
    this.dialogRef.close('DISCARDED');
  }
}
