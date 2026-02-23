class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.54.2"
    checksums = {
        "darwin_arm64" => "4a2838d50aa0673d94a9362030c7ef6488395d8727f2430cfdb353c448b87324",
        "darwin_amd64" => "39d0868c94a247cb6bd0d3e35c0b1eb02a571e4bb36683ce084f56556d161e35",
        "linux_arm64"  => "31937bc9ce12d3b131015f8d325904cac18a34d92049ceea7526ddb2f919521b",
        "linux_amd64"  => "4e6ec25f75b3eca49ac527bcef10271cfec3a2159b395cea738b7706bd4dc6ba",
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
