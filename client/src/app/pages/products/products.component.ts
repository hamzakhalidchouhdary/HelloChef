import { Component } from '@angular/core';
import { ProductService } from '../../services/product/product.service';
import { NotificationService } from '../../services/notification/notification.service';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { EditProductComponent } from 'src/app/components/edit-product/edit-product.component';

interface Product {
  title: string;
  id: number;
  description: string;
  price: number;
};

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent {
  constructor(private productService: ProductService, private notificationService: NotificationService, private dialog: MatDialog) {}
  isLoading: Boolean = true;
  products: Array<Product> = [];
  searchString: string = '';

  filterProducts(): Array<Product> {
    if (!this.searchString) return this.products; 
    return this.products.filter((product: Product) => {
      return product.title.includes(this.searchString);
    })
  };

  newProduct() {
    let newProduct: Product = {} as Product;
    this.editProduct(newProduct);
    this.products.push(newProduct);
  }

  editProduct(targetProduct: Product) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.data = targetProduct;

    this.dialog.open(EditProductComponent, dialogConfig);
  }

  fetchProducts(): void {
    this.productService.fetchProducts().subscribe(
      (data) => { 
        this.isLoading = false;
        this.products = data.items;
      },
      (error) => { 
        console.error(error); 
        this.notificationService.showSuccess('error occure')
      }
    );
  }

  ngOnInit() {
    this.fetchProducts();
  }
}
