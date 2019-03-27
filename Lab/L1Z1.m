original_image=imread('dogmatic.jpg');
if (size(original_image,3)~=3)
    try 
        original_image=demosaic(original_image);
    catch e
        try 
            original_image=ind2rgb(original_image);
        catch e
        end
    end
end
    
gray_image=rgb2gray(original_image);

gray_image=im2double(gray_image);

Christmas = [0 1.0 0
            1.0 0 0];
        
colormap(Christmas); 

whitepixels=zeros(1,101);
blackpixels=zeros(1,101);
blackpixelspercent=zeros(1,101);


L=linspace(0,1,101);
for i=1:101
    figure(1);
    Li=L(i);
    
    binary_image=imbinarize(gray_image,Li); 
    imshow(binary_image,Christmas);
    [counts,~]=imhist(binary_image);
    blackpixels(i)=counts(1);
    
    whitepixels(i)=counts(2);
    blackpixelspercent(i)=100*blackpixels(i)/(whitepixels(i)+blackpixels(i));

end



figure(2)
% plot(L,blackpixels);
plot(L,blackpixelspercent);





    