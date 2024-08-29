class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @current_page = 'home'
    @product = Product.new
    if Order.any?
      @order = Order.last
    else
      @order = Order.create(total_price: 0)
    end
  end

  def creators
    @ali = {
      github_url: "https://github.com/alinumbercrunch",
      github_username: "alinumbercrunch",
      name: "Ali",
      cute_name: "Ali ૮ ᴖﻌᴖა",
      image_url: "https://res.cloudinary.com/dxarsyyur/image/upload/v1724901852/74129604_krtcuw.jpg",
      title: "Backend Lead",
      linkedin: "https://www.linkedin.com/in/ali-h-a22178109/"
    }
    @mint = {
      github_url: "https://github.com/Sadanan-V",
      github_username: "Sadanan-V",
      name: "Mint",
      cute_name: "Sadanan(Mint)ʕ•ᴥ•ʔ",
      image_url: "https://res.cloudinary.com/dxarsyyur/image/upload/v1724902166/DSC01569_zx3otu.jpg",
      title: "Frontend Lead",
      linkedin: "https://www.linkedin.com/in/%F0%9F%AA%90sadanan-vorlaruxtara%F0%9F%AA%90-071a39110/"
    }
    @eri = {
      github_url: "https://github.com/eyawata",
      github_username: "eyawata",
      name: "Eri",
      cute_name: "Eri Eyawata ≽^•⩊•^≼",
      image_url: "https://res.cloudinary.com/djqladxhq/image/upload/v1724902487/photo_2024-08-29_12-34-23_qfwpm6.jpg",
      title: "Development Lead",
      linkedin: "https://www.linkedin.com/in/eriyawata/"
    }
    @jonas = {
      github_url: "https://github.com/Jonas-09",
      github_username: "Jonas-09",
      name: "Jonas",
      cute_name: "Jonas ૮ ˙Ⱉ˙ ა",
      image_url: "https://collection.cloudinary.com/dizzbqrfl/8675d5b4c22448cf8fc855c44fe47c72?",
      title: "Project Manager",
      linkedin: "https://www.linkedin.com/in/jonas-al-taher/"
    }
    @members = [@ali, @mint, @eri, @jonas]
  end
end
