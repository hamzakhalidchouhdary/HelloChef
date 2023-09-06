import { Component } from '@angular/core';
import { ProductService } from '../services/product/product.service';
import { NotificationService } from '../services/notification/notification.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent {
  constructor(private productService: ProductService, private notificationService: NotificationService) {}

  ngOnInit() {
    this.productService.fetchProducts().subscribe(
      (data) => { console.log(data); },
      (error) => { 
        console.error(error); 
        this.notificationService.showSuccess('error occure')
      }
    );
  }
}
