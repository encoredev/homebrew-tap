class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.10"
    checksums = {
        "darwin_arm64" => "ff6d273f7949a64c428bcec79992b0b88ee04ba79a9c4ba31a34411d1681adc1",
        "darwin_amd64" => "0725a5db577be4e2b74402853717cea05e25f6ae5538a854aeaf0c074b4f5418",
        "linux_arm64"  => "ec5c2e7d492ecb0dd2c9d99edcd4e9530c1e2964137319cfb573b4425f4c147a",
        "linux_amd64"  => "1c57b1fd01d7e534a8dfbae3919657062ff263a8dfd2fab8c18388d2e3d51b2d",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
