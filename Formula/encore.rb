class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.45.6"
    checksums = {
        "darwin_arm64" => "ddecb99010aa9f00ee2c089bf32cc1a7f79e7df141c560516337692d3f4795fc",
        "darwin_amd64" => "1b8641ed9ad271847fd6ccd867271def4fa0d0c9e65dc4b780f706102415b368",
        "linux_arm64"  => "a679e0d4045d63cd23217b28609ac7796e3d01f7ffc51d8b3e3952928785c693",
        "linux_amd64"  => "bd7c61d830e914963e3483e89d5a6473f8cfdc183ad50eb2acaa1631b82610c4",
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
