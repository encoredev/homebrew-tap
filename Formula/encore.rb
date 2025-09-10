class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.50.0"
    checksums = {
        "darwin_arm64" => "2f7004298ebccfc3b1a9f57481637b4943c593bdb223eb6103a197e744a89ca1",
        "darwin_amd64" => "44cdd2c50155d2d837f19679091f0558a135e3d675c339952978eeb0c37c2cca",
        "linux_arm64"  => "551f87f8ef2930719f0fd386497dd6a50099d2ef53ba4de91a559aa530882d8c",
        "linux_amd64"  => "1d4489cc8bb3faf9605792db456d27faef36ca62397f0c78923f123d12ed63ff",
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
