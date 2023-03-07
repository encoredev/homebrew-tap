class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230307"
    checksums = {
        "darwin_arm64" => "34650cba65fd76a81b9b27734e03717f03bdec4876d24dc8d5f806dfc6bc0862",
        "darwin_amd64" => "e0cfcba92ac07bc901b8bfec4bbd841a27522f2ff08f4626fbfd8186a0199a41",
        "linux_arm64"  => "337895d88eb6ec77cab155df5be5966c0c8702439914c7630c74ac5658dd40a6",
        "linux_amd64"  => "640934ce2131cb637080901d8b8e26900b52de1308a67bfd52b6722c0e313731",
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
