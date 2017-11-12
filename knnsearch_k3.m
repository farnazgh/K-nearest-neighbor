tic

k=3;

data = importdata('data.txt',',');

num_train_data = round(0.8*size(data,1));
num_test_data = size(data,1) - num_train_data;


sum_accuracy =0;
accuracy_vector = [];

for i=1:30
  rp = randperm(size(data,1));
  train_data = data(rp(1:num_train_data),:); 
  test_data = data(rp(num_train_data+1:num_train_data+num_test_data),:);
  
  %calculate Euclidean distance by knnsearch
  [n,d]=knnsearch(train_data,test_data,'k',k,'distance','euclidean');%cosine
  
  %for each test data
  num_correct =0;
  for j=1:num_test_data
    sample = test_data(j,:);
    
    first_nearest_sample_index = n(j,1);
    second_nearest_sample_index = n(j,2);
    third_nearest_sample_index = n(j,3);
    
    if((sample(1) == train_data(second_nearest_sample_index ,1)) && (sample(1) == train_data(first_nearest_sample_index ,1)) )
       num_correct = num_correct +1;
    elseif ((sample(1) == train_data(third_nearest_sample_index ,1)) && (sample(1) == train_data(first_nearest_sample_index ,1)) )
       num_correct = num_correct +1;
    elseif ((sample(1) == train_data(second_nearest_sample_index ,1)) && (sample(1) == train_data(third_nearest_sample_index ,1)) )
       num_correct = num_correct +1;
    elseif (sample(1) == train_data(first_nearest_sample_index ,1))
       num_correct = num_correct +1;
    end
    
  end
  
  accuracy = num_correct / num_test_data;
  sum_accuracy = sum_accuracy + accuracy;
  
  accuracy_vector = [accuracy_vector accuracy];
  
end


avg_accuracy = sum_accuracy / 30

var_accuracy = sum((accuracy_vector - avg_accuracy).^ 2)

toc