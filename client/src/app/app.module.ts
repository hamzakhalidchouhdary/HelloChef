import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ProductsComponent } from './pages/products/products.component';
import { StaffComponent } from './pages/staff/staff.component';
import { ProductService } from './services/product/product.service';
import { HttpClientModule } from '@angular/common/http';
import { ToastrModule } from 'ngx-toastr';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import { NotificationService } from './services/notification/notification.service';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';
import { FormsModule } from '@angular/forms';
import { MatDialogModule } from '@angular/material/dialog';

@NgModule({
  declarations: [
    AppComponent,
    ProductsComponent,
    StaffComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    NgxSkeletonLoaderModule,
    FormsModule,
    MatDialogModule,
    ToastrModule.forRoot({
      // Customize Toastr options here
      positionClass: 'toast-top-right', // Position of notifications
      preventDuplicates: true, // Prevent duplicate notifications
      closeButton: true, // Show close button
      progressBar: true, // Show progress bar
      timeOut: 3000, // Time (in milliseconds) before auto-dismissing notifications
      extendedTimeOut: 1000, // Additional time (in milliseconds) for extended timeout
      // Apply custom classes to notification types
      // toastClass: 'ngx-toastr',
      // iconClasses: {
      //   success: 'custom-success', // Apply custom success class
      //   error: 'custom-error', // Apply custom error class
      //   // Add custom classes for other notification types as needed
      // }
    })
  ],
  providers: [ProductService, NotificationService],
  bootstrap: [AppComponent]
})
export class AppModule { }
