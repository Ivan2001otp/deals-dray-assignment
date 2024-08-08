class HomeResponse {
  HomeResponse({
    required this.status,
    required this.data,
  });

  final int? status;
  final Data? data;

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'],
      data: json['data'] == null ? null : Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<Banner> bannerOne;
  final List<Category> category;
  final List<Product> products;
  final List<Banner> bannerTwo;
  final List<NewArrivals> newArrivals;
  final List<Banner> bannerThree;
  final List<CategoryListing> categoriesListing;

  final List<TopBrand> topBrands;
  final List<BrandListing> brandListing;

  final List<TopSellingProduct> topSellingProducts;
  final List<FeaturedLaptop> featuredLaptop;
  final List<UpcomingLaptop> upcomingLaptops;
  final List<UnboxedDeal> unboxedDeals;
  final List<BrowsingHistory> myBrowsingHistory;

  Data({
    required this.bannerOne,
    required this.category,
    required this.products,
    required this.bannerTwo,
    required this.newArrivals,
    required this.bannerThree,
    required this.categoriesListing,
    required this.topBrands,
    required this.brandListing,
    required this.topSellingProducts,
    required this.featuredLaptop,
    required this.upcomingLaptops,
    required this.unboxedDeals,
    required this.myBrowsingHistory,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      bannerOne: json["banner_one"] == null
          ? []
          : List<Banner>.from(
              json["banner_one"]!.map((x) => Banner.fromJson(x))),
      category: json["category"] == null
          ? []
          : List<Category>.from(
              json["category"]!.map((x) => Category.fromJson(x))),
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x))),
      bannerTwo: json["banner_two"] == null
          ? []
          : List<Banner>.from(
              json["banner_two"]!.map((x) => Banner.fromJson(x))),
      newArrivals: json["new_arrivals"] == null
          ? []
          : List<NewArrivals>.from(
              json["new_arrivals"]!.map((x) => NewArrivals.fromJson(x))),
      
      bannerThree: json["banner_three"] == null
          ? []
          : List<Banner>.from(
              json["banner_three"]!.map((x) => Banner.fromJson(x))),

      categoriesListing: json["categories_listing"] == null
          ? []
          : List<CategoryListing>.from(
              json["categories_listing"]!.map((x) => CategoryListing.fromJson(x))),
      
      topBrands: json["top_brands"] == null
          ? []
          : List<TopBrand>.from(
              json["top_brands"]!.map((x) => TopBrand.fromJson(x))),
    
      brandListing: json["brand_listing"] == null
          ? []
          : List<BrandListing>.from(
              json["brand_listing"]!.map((x) => BrandListing.fromJson(x))),
     
      topSellingProducts: json["top_selling_products"] == null
          ? []
          : List<TopSellingProduct>.from(
              json["top_selling_products"]!.map((x) => TopSellingProduct.fromJson(x))),
   
      featuredLaptop: json["featured_laptop"] == null
          ? []
          : List<FeaturedLaptop>.from(
              json["featured_laptop"]!.map((x) => FeaturedLaptop.fromJson(x))),
     
     
      upcomingLaptops: json["upcoming_laptops"] == null
          ? []
          : List<UpcomingLaptop>.from(
              json["upcoming_laptops"]!.map((x) => UpcomingLaptop.fromJson(x))),
      
      unboxedDeals: json["unboxed_deals"] == null
          ? []
          : List<UnboxedDeal>.from(
              json["unboxed_deals"]!.map((x) => UnboxedDeal.fromJson(x))),
      
      myBrowsingHistory: json["my_browsing_history"] == null
          ? []
          : List<BrowsingHistory>.from(json["my_browsing_history"]!
              .map((x) => BrowsingHistory.fromJson(x))),
    );
  }
}

class FeaturedLaptop {
  final String? icon;
  final String? brandIcon;
  final String? label;
  final String? price;

  FeaturedLaptop({
    required this.icon,
    required this.brandIcon,
    required this.label,
    required this.price,
  });

  factory FeaturedLaptop.fromJson(Map<String, dynamic> json) {
    return FeaturedLaptop(
      icon: json["icon"],
      brandIcon: json["brandIcon"],
      label: json["label"],
      price: json["price"],
    );
  }
}

class UpcomingLaptop {
  final String? icon;
  UpcomingLaptop({
    required this.icon,
  });

  factory UpcomingLaptop.fromJson(Map<String, dynamic> json) {
    return UpcomingLaptop(icon: json['icon']);
  }
}

class UnboxedDeal {
  final String? icon;
  final String? offer;
  final String? label;

  UnboxedDeal({
    required this.icon,
    required this.offer,
    required this.label,
  });

  factory UnboxedDeal.fromJson(Map<String, dynamic> json) {
    return UnboxedDeal(
      icon: json["icon"],
      offer: json["offer"],
      label: json["label"],
    );
  }
}

class BrowsingHistory {
  final String? icon;
  final String? offer;
  final String? brandIcon;
  final String? label;

  BrowsingHistory({
    required this.icon,
    required this.offer,
    required this.brandIcon,
    required this.label,
  });

  factory BrowsingHistory.fromJson(Map<String, dynamic> json) {
    return BrowsingHistory(
      icon: json["icon"],
      offer: json["offer"],
      brandIcon: json["brandIcon"],
      label: json["label"],
    );
  }
}

class Banner {
  Banner({
    required this.banner,
  });

  final String? banner;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      banner: json["banner"],
    );
  }
}

class NewArrivals {
  final String? icon;
  final String? offer;
  final String? brandedIcon;
  final String? label;

  NewArrivals({
    required this.icon,
    required this.offer,
    required this.brandedIcon,
    required this.label,
  });

  factory NewArrivals.fromJson(Map<String, dynamic> json) {
    return NewArrivals(
      icon: json["icon"],
      offer: json["offer"],
      brandedIcon: json["brandIcon"],
      label: json["label"],
    );
  }
}

class CategoryListing {
  final String? icon;
  final String? offer;
  final String? label;

  CategoryListing({
    required this.icon,
    required this.offer,
    required this.label,
  });

  factory CategoryListing.fromJson(Map<String, dynamic> json) {
    return CategoryListing(
      icon: json["icon"],
      offer: json["offer"],
      label: json["label"],
    );
  }
}

class BrandListing {
  BrandListing({
    required this.icon,
    required this.offer,
    required this.brandIcon,
    required this.label,
  });

  final String? icon;
  final String? offer;
  final String? brandIcon;
  final String? label;

  factory BrandListing.fromJson(Map<String, dynamic> json) {
    return BrandListing(
      icon: json["icon"],
      offer: json["offer"],
      brandIcon: json["brandIcon"],
      label: json["label"],
    );
  }
}

class Category {
  Category({
    required this.label,
    required this.icon,
  });

  final String? label;
  final String? icon;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      label: json["label"],
      icon: json["icon"],
    );
  }
}

class Product {
  Product({
    required this.icon,
    required this.offer,
    required this.label,
    required this.subLabel,
  });

  final String? icon;
  final String? offer;
  final String? label;
  final String? subLabel;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      icon: json["icon"],
      offer: json["offer"],
      label: json["label"],
      subLabel: json["SubLabel"],
    );
  }
}

class TopBrand {
  TopBrand({
    required this.icon,
  });

  final String? icon;

  factory TopBrand.fromJson(Map<String, dynamic> json) {
    return TopBrand(
      icon: json["icon"],
    );
  }
}

class TopSellingProduct {
  final String? icon;
  final String? label;

  TopSellingProduct({
    required this.icon,
    required this.label,
  });

  factory TopSellingProduct.fromJson(Map<String, dynamic> json) {
    return TopSellingProduct(
      icon: json['icon'],
      label: json['label'],
    );
  }
}
