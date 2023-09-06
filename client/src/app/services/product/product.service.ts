import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private productUrl = 'http://127.0.0.1:57056/api/v1/item';

  constructor(private httpClient: HttpClient) { }

  fetchProducts(): Observable<any> {
    return this.httpClient
      .get<any>(this.productUrl)
      .pipe(catchError((error: any) => {
        return throwError(() => {
          let err = new Error('error in fetching products');
          err.message = error.error.error;
          return err;
        });
      })
    );
  }
}
