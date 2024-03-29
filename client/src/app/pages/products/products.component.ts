import { Component } from '@angular/core';
import { ProductService } from '../../services/product/product.service';
import { NotificationService } from '../../services/notification/notification.service';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { EditProductComponent } from 'src/app/components/edit-product/edit-product.component';
import Product from 'src/app/models/product.model';
import _ from 'lodash';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss'],
})
export class ProductsComponent {
  constructor(
    private productService: ProductService,
    private notificationService: NotificationService,
    private dialog: MatDialog
  ) {}
  isLoading: Boolean = true;
  products: Array<Product> = [];
  searchString: string = '';

  filterProducts(): Array<Product> {
    if (!this.searchString) return this.products;
    return this.products.filter((product: Product) => {
      return product.title.includes(this.searchString);
    });
  }

  discardChanges(productBackUp: Product) {
    const targetProductIndex = this.products.findIndex(
      (product) => product.id == productBackUp.id
    );
    if (targetProductIndex < 0) return;
    this.products.splice(targetProductIndex, 1, productBackUp);
  }

  newProduct() {
    let newProduct: Product = { labels: [] } as unknown as Product;
    this.editProduct(newProduct);
  }

  editProduct(targetProduct: Product) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.data = targetProduct;
    const productBackUp: Product =  _.cloneDeep(targetProduct);

    this.dialog
      .open(EditProductComponent, dialogConfig)
      .afterClosed()
      .subscribe((status: String) => {
        switch (status) {
          case 'SAVED':
            break;
          case 'CREATED':
            this.products.push(targetProduct);
            break;
          case 'DISCARDED':
            this.discardChanges(productBackUp);
            break;
        }
      });
  }

  removeProduct(id: Number) {
    this.productService.removeProduct(id).subscribe({
      next: (data) => {
        const targetProductIndex = this.products.findIndex(
          (product) => product.id == id
        );
        this.products.splice(targetProductIndex, 1);
      },
      error: (error) => {},
      complete: undefined,
    });
  }

  fetchProducts(): void {
    this.productService.fetchProducts().subscribe({
      next: (data) => {
        this.isLoading = false;
        this.products = data.items;
      },
      error: (error) => {
        console.error(error);
        this.notificationService.showError('error occure');
      },
      complete: undefined,
    });
  }

  ngOnInit() {
    this.fetchProducts();
  }
}
