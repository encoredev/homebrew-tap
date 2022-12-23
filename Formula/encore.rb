class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.12.0"
    checksums = {
        "darwin_arm64" => "fb349ac08789413be2679261058d7c88cf3a06f1a1e9b725b37bb871bcdc7dd5",
        "darwin_amd64" => "6641ee9387e90fd9f2085971af22fd3d05d79ef963195064c5d07ec6dc9b17b2",
        "linux_arm64"  => "2f072e8381c66ae0ddd1ded43c32aac487fe239ea96fd6139383d7ef64a1d3bb",
        "linux_amd64"  => "a4dd83a44c0526a5bc7e3e1f588667c668489d029aaa2d55909d7065ff2eacd4",
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
